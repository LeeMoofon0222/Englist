import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gt_test_app/Components/translateTextField.dart';
import 'package:gt_test_app/pages/vocabulary_page.dart';
import 'package:firebase_database/firebase_database.dart';

import '../pages/sentence_page.dart';

class VocabularyItem extends StatefulWidget {
  VocabularyItem({required this.vocabulary, required this.removeVocabulary})
      : super(key: ObjectKey(vocabulary));

  final Function removeVocabulary;
  final Vocabulary vocabulary;

  @override
  State<VocabularyItem> createState() => _VocabularyItemState();
}

class _VocabularyItemState extends State<VocabularyItem> {
  final GlobalKey<_VocabularyItemState> _key = GlobalKey();
  final user = FirebaseAuth.instance.currentUser;
  String mainWordText = "";
  String associateWordText = "";
  late IconData starData;
  final vocabularyTranslateController = TextEditingController();
  final vocabularyDetectController = TextEditingController();
  DatabaseReference firebaseDB = FirebaseDatabase.instance.ref();



  void _update(String bMainWord, String bAssociateWord, String aMainWord,
      String aAssociateWord, String ifStore) {
    Map<String, String> before = {
      "mainWord": bMainWord,
      "associateWord": bAssociateWord
    };
    Map<String, String> after = {
      "mainWord": aMainWord,
      "associateWord": aAssociateWord,
      "ifStore": ifStore
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

  void _remove(String mainWord, String associateWord) {
    Map<String, String> vocab = {
      "mainWord": mainWord,
      "associateWord": associateWord
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
        if (value['mainWord'] == vocab['mainWord'] &&
            value['associateWord'] == vocab['associateWord']) {
          firebaseDB
              .child("user")
              .child(user!.uid)
              .child("EnglishVocab")
              .child(key)
              .remove();
        }
      });
    });
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            content: SizedBox(
              width: 280,
              height: 160,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        '編輯單字',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 300,
                      height: 43,
                      child: TranslateTextField(
                        controller: vocabularyDetectController,
                        hintText: '',
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 300,
                      height: 43,
                      child: TranslateTextField(
                        controller: vocabularyTranslateController,
                        hintText: '',
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
                  Navigator.of(context).pop();
                  _remove(vocabularyDetectController.text,
                      vocabularyTranslateController.text);
                  widget.removeVocabulary(widget.vocabulary);
                },
                child: const Text(
                  '刪除',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
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
                  setState(() {
                    mainWordText = vocabularyDetectController.text;
                    associateWordText = vocabularyTranslateController.text;
                    _update(
                        widget.vocabulary.mainWord,
                        widget.vocabulary.associateWord,
                        mainWordText,
                        associateWordText,
                        widget.vocabulary.ifStore);
                    widget.vocabulary.mainWord =
                        vocabularyDetectController.text;
                    widget.vocabulary.associateWord =
                        vocabularyTranslateController.text;
                  });
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
        });
  }

  void showSentenceAlert(BuildContext context) {
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => SentencePage(
          word: mainWordText,
          associateWord: associateWordText,
            sentence: widget.vocabulary.sentence,
          associateSentence: widget.vocabulary.associateSentence
        ),
      ),);
  }

  void removeWidget() {
    final state = _key.currentState;
    if (state != null) {
      state.setState(() {
        // Remove the widget from the widget tree.
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mainWordText = widget.vocabulary.mainWord;
    associateWordText = widget.vocabulary.associateWord;
    if(widget.vocabulary.ifStore=="true"){
      starData = Icons.star;
    }
    else{
      starData = Icons.star_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()
      {
        showSentenceAlert(context);
      },
      title: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainWordText,
                style: const TextStyle(color: Colors.black, fontSize: 28),
              ),
              Text(
                associateWordText,
                style: const TextStyle(color: Colors.black, fontSize: 23),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                if (starData == Icons.star_border) {
                  starData = Icons.star;
                  widget.vocabulary.ifStore = "true";
                } else {
                  widget.vocabulary.ifStore = "false";
                  starData = Icons.star_border;
                }
                _update(
                    widget.vocabulary.mainWord,
                    widget.vocabulary.associateWord,
                    mainWordText,
                    associateWordText,
                    widget.vocabulary.ifStore);
              });

            },
            alignment: Alignment.centerLeft,
            icon: Icon(
              starData,
              size: 35,
            )),
        const SizedBox(width: 10),

        IconButton(
          iconSize: 30,
          icon: const Icon(
            Icons.edit,
          ),
          alignment: Alignment.topLeft,
          onPressed: () {
            vocabularyDetectController.text = widget.vocabulary.mainWord;
            vocabularyTranslateController.text =
                widget.vocabulary.associateWord;
            showAlert(context);
          },
        ),
      ]),
      //subtitle: Text(vocabulary.associateWord, style: const TextStyle(color: Colors.black, fontSize: 15)),
    );
  }
}
