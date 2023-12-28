import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gt_test_app/Components/translateTextField.dart';
import 'package:gt_test_app/Components/vocabularyItem.dart';
import 'package:gt_test_app/pages/InPage_register_page.dart';
import 'package:gt_test_app/pages/register_page.dart';
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
  Vocabulary({required this.mainWord, required this.associateWord});

  String mainWord;
  String associateWord;
}

class _VocabularyPageState extends State<VocabularyPage> {
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

  @override
  void initState() {
    _translation = Translation(
      apiKey: 'AIzaSyDervpmYXev4zhSuKTgFC9SVnLfQYpRJNg', //填入API金鑰，為避免濫用，因此已隱藏
    );
    super.initState();
  }

/*
  void _create(String mainWord, String associateWord) {
    mainList.add(mainWord);
    associateList.add(associateWord);
    Map<String, List<String>> data = {
      "mainWord": mainList,
      "associateWord": associateList
    };

  void _read(String mainWord, String associateWord) {
    mainList.add(mainWord);
    associateList.add(associateWord);
    Map<String, List<String>> data = {
      "mainWord": mainList,
      "associateWord": associateList
    };

  void _update(String mainWord, String associateWord) {
    mainList.add(mainWord);
    associateList.add(associateWord);
    Map<String, List<String>> data = {
      "mainWord": mainList,
      "associateWord": associateList
    };

  void _delete(String mainWord, String associateWord) {
    mainList.add(mainWord);
    associateList.add(associateWord);
    Map<String, List<String>> data = {
      "mainWord": mainList,
      "associateWord": associateList
    };


  }
  void _fetch(){
    firebaseDB.child("user/${user?.uid}").once().then((DataSnapshot snapshot){
      var user = snapshot.value;
      setState((){
        userSubject = user['userSubject'];
      });
    } as FutureOr Function(DatabaseEvent value)).catchError((error){
      print(error);
    });
  }*/

  void _addVocabulary(String mainWord, String associateWord) {
    setState(() {
      _vocabularies
          .add(Vocabulary(mainWord: mainWord, associateWord: associateWord));
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
    final user = FirebaseAuth.instance.currentUser;
    if (user?.email != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            title: const Text(
              "確定要登出嗎",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                  FirebaseAuth.instance.signOut();
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
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            title:
              const Column(
                children: [
                  Text(
                    "確定要登出嗎，資料將遺失",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "登入以儲存資料",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w200),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    goToLogin = true; // 使用 setState 進行重繪
                  });
                },
                child: const Text(
                  '登入',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                  FirebaseAuth.instance.signOut();
                  /*Delete用戶*/
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
                      if ((vocabularyChineseController.text != '' &&
                          vocabularyEnglishController.text == '') || downWord != vocabularyChineseController.text) {
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
                      downWord = vocabularyChineseController.text;
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
                if (vocabularyChineseController.text != "" &&
                    vocabularyEnglishController.text != "") {
                  Navigator.of(context).pop();
                  _addVocabulary(vocabularyEnglishController.text,
                      vocabularyChineseController.text);
                  vocabularyEnglishController.clear();
                  vocabularyChineseController.clear();
                } else {
                  showError("字串不得為空白");
                }
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
    if(goToLogin){
    return const InpageRegisterPage(onTap: null);
    }
    else{
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
            return VocabularyItem(
              vocabulary: vocabulary,
              removeVocabulary: _deleteItem,
            );
          }).toList(),
        ),
        bottomNavigationBar: const BottomAppBarWidget(),
        backgroundColor: Colors.grey[300],
      );
    }
  }
}
