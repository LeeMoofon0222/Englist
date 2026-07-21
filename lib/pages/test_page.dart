import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../main.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class QuizItem {
  final String question;
  final String correctAnswer;
  final List<String> options;

  QuizItem({
    required this.question,
    required this.correctAnswer,
    required this.options,
  });
}

class _TestPageState extends State<TestPage> with AutomaticKeepAliveClientMixin {
  final user = FirebaseAuth.instance.currentUser;
  final DatabaseReference firebaseDB = FirebaseDatabase.instance.ref();

  bool _isLoading = true;
  List<QuizItem> _quizList = [];
  int _currentIndex = 0;
  int _score = 0;
  String? _selectedOption;
  bool _hasAnswered = false;

  final List<Map<String, String>> _defaultVocab = [
    {"main": "Apple", "assoc": "蘋果"},
    {"main": "Banana", "assoc": "香蕉"},
    {"main": "Challenge", "assoc": "挑戰"},
    {"main": "Knowledge", "assoc": "知識"},
    {"main": "Success", "assoc": "成功"},
    {"main": "Learning", "assoc": "學習"},
    {"main": "Vocabulary", "assoc": "單字"},
    {"main": "Developer", "assoc": "開發者"},
  ];

  @override
  void initState() {
    super.initState();
    _loadAndPrepareQuiz();
  }

  Future<void> _loadAndPrepareQuiz() async {
    setState(() {
      _isLoading = true;
      _currentIndex = 0;
      _score = 0;
      _hasAnswered = false;
      _selectedOption = null;
    });

    List<Map<String, String>> vocabList = [];

    if (user != null) {
      try {
        final snapshot = await firebaseDB
            .child("user")
            .child(user!.uid)
            .child("EnglishVocab")
            .get();

        if (snapshot.exists && snapshot.value is Map) {
          final data = snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            if (value['mainWord'] != null && value['associateWord'] != null) {
              vocabList.add({
                "main": value['mainWord'].toString(),
                "assoc": value['associateWord'].toString(),
              });
            }
          });
        }
      } catch (e) {
        // Fallback to default vocab
      }
    }

    if (vocabList.length < 3) {
      vocabList.addAll(_defaultVocab);
    }

    // Generate Quiz Items
    final random = Random();
    vocabList.shuffle(random);

    final allChineseAnswers = vocabList.map((e) => e["assoc"]!).toSet().toList();

    List<QuizItem> generatedQuiz = [];
    for (var item in vocabList) {
      final mainWord = item["main"]!;
      final correctAssoc = item["assoc"]!;

      List<String> options = [correctAssoc];
      List<String> distractorPool = List.from(allChineseAnswers)..remove(correctAssoc);
      distractorPool.shuffle(random);

      for (var d in distractorPool) {
        if (options.length < 4) {
          options.add(d);
        }
      }

      while (options.length < 4) {
        options.add("選項 ${options.length + 1}");
      }

      options.shuffle(random);

      generatedQuiz.add(QuizItem(
        question: mainWord,
        correctAnswer: correctAssoc,
        options: options,
      ));
    }

    setState(() {
      _quizList = generatedQuiz;
      _isLoading = false;
    });
  }

  void _answerQuestion(String option) {
    if (_hasAnswered) return;

    final currentQuestion = _quizList[_currentIndex];
    setState(() {
      _selectedOption = option;
      _hasAnswered = true;
      if (option == currentQuestion.correctAnswer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _quizList.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _hasAnswered = false;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Quiz Finished!",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events, size: 60, color: Colors.amber),
              const SizedBox(height: 12),
              Text(
                "Your Score: $_score / ${_quizList.length}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _score == _quizList.length
                    ? "Perfect score! Outstanding work! 🎉"
                    : "Great effort! Keep practicing! 💪",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _loadAndPrepareQuiz();
                },
                child: const Text("Try Again", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  void signUserOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: const Text(
            "Logout?",
            style: TextStyle(
                color: Colors.black, fontSize: 21, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () async {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/');
                }
              },
              child: const Text('yes', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocabulary Quiz",
            style: TextStyle(color: Colors.white, fontSize: 23)),
        backgroundColor: Colors.grey[800],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () => signUserOut(context),
            icon: const Icon(Icons.logout, size: 30),
            color: Colors.white,
          )
        ],
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
      backgroundColor: Colors.grey[200],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _quizList.isEmpty
              ? const Center(child: Text("No questions available"))
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Progress Bar & Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Question ${_currentIndex + 1} / ${_quizList.length}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Score: $_score",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: (_currentIndex + 1) / _quizList.length,
                        backgroundColor: Colors.grey[400],
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                      const SizedBox(height: 30),

                      // Card Question
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 36, horizontal: 20),
                          child: Column(
                            children: [
                              const Text(
                                "Choose the correct Chinese meaning:",
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _quizList[_currentIndex].question,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Options List
                      Expanded(
                        child: ListView.builder(
                          itemCount: _quizList[_currentIndex].options.length,
                          itemBuilder: (context, idx) {
                            final option = _quizList[_currentIndex].options[idx];
                            final correctAnswer =
                                _quizList[_currentIndex].correctAnswer;

                            Color btnColor = Colors.white;
                            Color textColor = Colors.black87;

                            if (_hasAnswered) {
                              if (option == correctAnswer) {
                                btnColor = Colors.green[400]!;
                                textColor = Colors.white;
                              } else if (option == _selectedOption) {
                                btnColor = Colors.red[400]!;
                                textColor = Colors.white;
                              }
                            }

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: btnColor,
                                  foregroundColor: textColor,
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => _answerQuestion(option),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${String.fromCharCode(65 + idx)}.  $option",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: textColor),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Next Button
                      if (_hasAnswered)
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _nextQuestion,
                          icon: const Icon(Icons.arrow_forward, color: Colors.white),
                          label: Text(
                            _currentIndex < _quizList.length - 1
                                ? "Next Question"
                                : "See Results",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}