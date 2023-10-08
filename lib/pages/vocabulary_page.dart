import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gt_test_app/Components/translateTextField.dart';

//import '../Components/mytextfield.dart';
import 'package:gt_test_app/Components/vocabularyItem.dart';
import '../main.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';

class VocabularyPage extends StatefulWidget {
  final String text;

  VocabularyPage({super.key, required this.text});

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();

  final user = FirebaseAuth.instance.currentUser!;
}

class Vocabulary {
  Vocabulary({required this.mainWord, required this.associateWord});

  String mainWord;
  String associateWord;
}

class _VocabularyPageState extends State<VocabularyPage> {
  String receivedWord = '';
  late Translation _translation;
  TranslationModel _translated =
      TranslationModel(translatedText: '', detectedSourceLanguage: '');
  final vocabularyEnglishController = TextEditingController();
  final vocabularyChineseController = TextEditingController();
  final translateController = TextEditingController();
  final List<Vocabulary> _vocabularies = <Vocabulary>[];

  @override
  void initState() {
    _translation = Translation(
      apiKey: 'AIzaSyDervpmYXev4zhSuKTgFC9SVnLfQYpRJNg',
    );
    super.initState();
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void _addVocabulary(String mainWord, String associateWord) {
    setState(() {
      _vocabularies
          .add(Vocabulary(mainWord: mainWord, associateWord: associateWord));
    });
  }

  Future<void> showAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          content: SizedBox(
            width: 280,
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      '新增單字',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    width: 300,
                    height: 43,
                    child: TranslateTextField(
                      controller: vocabularyEnglishController,
                      hintText: '英文',
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.autorenew),
                    iconSize: 30,
                    onPressed: () async {
                      receivedWord = widget.text;
                      if (vocabularyChineseController.text != '' &&
                          vocabularyEnglishController.text == '') {
                        _translated = await _translation.translate(
                            text: vocabularyChineseController.text,
                            to: 'en'); //更改語言
                        vocabularyEnglishController.text =
                            _translated.translatedText;
                      } else {
                        _translated = await _translation.translate(
                            text: vocabularyEnglishController.text,
                            to: 'zh-TW'); //更改語言
                        vocabularyChineseController.text =
                            _translated.translatedText;
                      }
                    },
                  ),
                  SizedBox(
                    width: 300,
                    height: 43,
                    child: TranslateTextField(
                      controller: vocabularyChineseController,
                      hintText: '中文',
                      obscureText: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                vocabularyEnglishController.clear();
                vocabularyChineseController.clear();
              },
              child: const Text(
                '清空',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                vocabularyEnglishController.clear();
                vocabularyChineseController.clear();
              },
              child: const Text(
                '取消',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addVocabulary(vocabularyEnglishController.text,
                    vocabularyChineseController.text);
                vocabularyEnglishController.clear();
                vocabularyChineseController.clear();
              },
              child: const Text(
                '確定',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("收藏單字",
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.grey[800],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                showAlert(context);
              },
              icon: const Icon(
                Icons.add,
                size: 40,
              )),
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(
              Icons.logout,
              size: 30,
            ),
            color: Colors.white,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _vocabularies.map((Vocabulary vocabulary) {
          return VocabularyItem(vocabulary: vocabulary);
        }).toList(),
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
      backgroundColor: Colors.grey[300],
    );
  }
}
