import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gt_test_app/Components/translateTextField.dart';
import 'package:gt_test_app/Components/vocabularyItem.dart';
import '../main.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';
import 'package:firebase_database/firebase_database.dart';

class VocabularyPage extends StatefulWidget {
  final String text;
  final Function()? onTap;

  const VocabularyPage({super.key, required this.text, required this.onTap});

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class Vocabulary {
  Vocabulary(
      {required this.mainWord,
      required this.associateWord,
        required this.sentence,
        required this.associateSentence,
      required this.ifStore});

  String mainWord;
  String associateWord;
  String sentence;
  String associateSentence;
  String ifStore;
}

class _VocabularyPageState extends State<VocabularyPage>
    with AutomaticKeepAliveClientMixin {
  final translateApiKey = dotenv.env['TRANSLATE_API_KEY'];
  String downWord = '';
  late Translation _translation;
  TranslationModel _translated =
      TranslationModel(translatedText: '', detectedSourceLanguage: '');
  bool goToLogin = false;
  final vocabularyEnglishController = TextEditingController();
  final vocabularyChineseController = TextEditingController();
  final translateController = TextEditingController();
  final List<Vocabulary> _vocabularies = <Vocabulary>[];
  DatabaseReference firebaseDB = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser;
  final List<String> mainList = [];
  final List<String> associateList = [];
  final List<String> storeList = [];
  late bool storeVocab = false;
  IconData starData = Icons.star_border;

  @override
  void initState() {
    super.initState();
    _fetch();
    _translation = Translation(
      apiKey: '$translateApiKey',
    );
  }

  void _push(String mainWord, String associateWord, String ifStore, String sentence, String associateSentence) {
    Map<String, String> vocab = {
      "mainWord": mainWord,
      "associateWord": associateWord,
      "ifStore": ifStore,
      "sentence": "",
      "associateSentence": ""
    };
    firebaseDB
        .child('user')
        .child(user!.uid)
        .child('EnglishVocab')
        .push()
        .set(vocab);
  }

  void _fetch() {
    firebaseDB
        .child("user")
        .child(user!.uid)
        .child("EnglishVocab")
        .once()
        .then((DatabaseEvent databaseEvent) {
      Map<dynamic, dynamic>? userData =
          databaseEvent.snapshot.value as Map<dynamic, dynamic>?;
      setState(() {
        userData?.forEach((key, value) {
          _vocabularies.add(Vocabulary(
              mainWord: value['mainWord'],
              associateWord: value['associateWord'],
              sentence: value['sentence'],
              associateSentence: value['associateSentence'],
              ifStore: value['ifStore']));
        });
      });
    });
  }

  void _addVocabulary(String mainWord, String associateWord, String ifStore) {
    setState(() {
      _vocabularies.add(Vocabulary(
          mainWord: mainWord, associateWord: associateWord, ifStore: ifStore, sentence: "", associateSentence: ""));
    });
  }

  void _deleteItem(Vocabulary vocabulary) {
    setState(() {
      _vocabularies
          .removeWhere((element) => element.mainWord == vocabulary.mainWord);
    });
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: Text(
            message,
            style: const TextStyle(
                color: Colors.black, fontSize: 21, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  void signUserOut() {
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'cancel',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text(
                'yes',
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
                      'New Vocab',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    height: 43,
                    child: TranslateTextField(
                      controller: vocabularyEnglishController,
                      hintText: 'English',
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.autorenew),
                    iconSize: 30,
                    onPressed: () async {
                      if ((vocabularyChineseController.text != '' &&
                          vocabularyEnglishController.text == '')) {
                        _translated = await _translation.translate(
                            text: vocabularyChineseController.text,
                            to: 'en'); ////中文轉英文
                        vocabularyEnglishController.text =
                            _translated.translatedText;
                      } else {
                        _translated = await _translation.translate(
                            text: vocabularyEnglishController.text,
                            to: 'zh-TW'); //更改語言
                        vocabularyChineseController.text =
                            _translated.translatedText;
                      } //英文轉中文
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
                'clear',
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
                'cancel',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () {
                if (vocabularyChineseController.text != "" &&
                    vocabularyEnglishController.text != "") {
                  Navigator.of(context).pop();
                  _addVocabulary(vocabularyEnglishController.text,
                      vocabularyChineseController.text, "false");
                  _push(vocabularyEnglishController.text,
                      vocabularyChineseController.text, "false", "", "");
                  vocabularyEnglishController.clear();
                  vocabularyChineseController.clear();
                } else {
                  showError("can't be empty");
                }
              },
              child: const Text(
                'yes',
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
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocab",
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.grey[800],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (starData == Icons.star_border) {
                    starData = Icons.star;
                  } else {
                    starData = Icons.star_border;
                  }
                  storeVocab = !storeVocab;
                });
              },
              icon: Icon(
                starData,
                size: 38,
              )),
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
          if (storeVocab && vocabulary.ifStore == "true") {
              return VocabularyItem(
                vocabulary: vocabulary,
                removeVocabulary: _deleteItem,
              );
          }
          else if(!storeVocab)
          {
            return VocabularyItem(
              vocabulary: vocabulary,
              removeVocabulary: _deleteItem,
            );
          }
          else{
            return Container();
          }
        }).toList(),
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
      drawer: const BurgerDrawerWidget(),
      backgroundColor: Colors.grey[300],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
