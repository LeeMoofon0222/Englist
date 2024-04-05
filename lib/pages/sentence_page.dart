import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SentencePage extends StatefulWidget {
  final String word;
  final String associateWord;
  final String sentence;
  final String associateSentence;
  final Function()? onTap;

  const SentencePage(
      {super.key, required this.word, required this.associateWord, this.onTap, required this.sentence, required this.associateSentence});

  @override
  State<SentencePage> createState() => _SentencePageState();
}

class _SentencePageState extends State<SentencePage> {
  final gptApiKey = dotenv.env['OPENAI_API_KEY'];
  final translateApiKey = dotenv.env['TRANSLATE_API_KEY'];
  String sentence = "";
  String associateSentence = "";
  DatabaseReference firebaseDB = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser;
  late Translation _translation;
  TranslationModel _translated =
      TranslationModel(translatedText: '', detectedSourceLanguage: '');

  @override
  void initState() {
    super.initState();
    sentence = widget.sentence;
    associateSentence = widget.associateSentence;
    _translation = Translation(
      apiKey: '$translateApiKey',
    );
  }

  void _update(String MainWord, String AssociateWord, String sentence, String associateSentence) {
    Map<String, String> before = {
      "mainWord": MainWord,
      "associateWord": AssociateWord,
      "sentence": widget.sentence,
      "associateSentence": widget.associateSentence
    };
    Map<String, String> after = {
      "mainWord": MainWord,
      "associateWord": AssociateWord,
      "sentence": sentence,
      "associateSentence": associateSentence,
    };

    firebaseDB
        .child("user")
        .child(user!.uid)
        .child("EnglishVocab")
        .once()
        .then((DatabaseEvent databaseEvent) {
      Map<dynamic, dynamic>? userVocab =
      databaseEvent.snapshot.value as Map<dynamic, dynamic>?;
      userVocab?.forEach((key, value) {
        if (value['mainWord'] == before['mainWord'] &&
            value['associateWord'] == before['associateWord']) {
          firebaseDB
              .child("user")
              .child(user!.uid)
              .child("EnglishVocab")
              .child(key)
              .update(after);
        }
      });
    });
  }

  Future<void> fetchResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer $gptApiKey',
        },
        body: jsonEncode(<String, dynamic>{
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = json.decode(response.body);
        setState(() {
          sentence = result['choices'][0]['message']['content'].trim();
        });
      } else {
        throw Exception('Failed to load response: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        sentence = "Error fetching response: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word and Sentence Display'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Word',
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              widget.word,
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(height: 10),
            Text(
              widget.associateWord,
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(height: 75),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await fetchResponse(
                      "Use the word ${widget.word} in a sentence. lower than 15 vocabularies");

                  _translated = await _translation.translate(
                      text: sentence, to: 'zh-TW'); //更改語言

                  setState(() {
                    associateSentence = _translated.translatedText;
                    _update(widget.word,widget.associateWord,sentence,associateSentence);
                  });//英文轉中文
                },
                child: const Text(
                  'Generate New Sentence',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 75),
            const Text(
              'Sentence',
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              sentence,
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(height: 10),
            Text(
              associateSentence,
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
