import 'package:flutter/material.dart';
import 'package:gt_test_app/Components/translateTextField.dart';
import 'package:gt_test_app/pages/vocabulary_page.dart';
import 'package:firebase_database/firebase_database.dart';

class VocabularyItem extends StatefulWidget {

  VocabularyItem({required this.vocabulary, required this.removeVocabulary})
      : super(key: ObjectKey(vocabulary));

  final Function removeVocabulary;
  final Vocabulary vocabulary;

  @override
  State<VocabularyItem> createState() => _VocabularyItemState();
}


  class _VocabularyItemState extends State<VocabularyItem>{
  final GlobalKey<_VocabularyItemState> _key = GlobalKey();
  String mainWordText = "";
  String associateWordText = "";
  final vocabularyTranslateController = TextEditingController();
  final vocabularyDetectController = TextEditingController();
  DatabaseReference firebaseDB = FirebaseDatabase.instance.ref();


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
                    widget.vocabulary.mainWord = vocabularyDetectController.text;
                    widget.vocabulary.associateWord = vocabularyTranslateController.text;
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
        }
    );
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
  void initState(){
    super.initState();
  mainWordText = widget.vocabulary.mainWord;
  associateWordText = widget.vocabulary.associateWord;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Row(children: <Widget>[
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
          iconSize: 30,
          icon: const Icon(
            Icons.edit,
          ),
          alignment: Alignment.topLeft,
          onPressed: () {
            vocabularyDetectController.text = widget.vocabulary.mainWord;
            vocabularyTranslateController.text = widget.vocabulary.associateWord;
            showAlert(context);
          },
        ),
      ]
      ),
      //subtitle: Text(vocabulary.associateWord, style: const TextStyle(color: Colors.black, fontSize: 15)),
    );
  }
}
