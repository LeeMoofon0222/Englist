import 'package:flutter/material.dart';
import 'package:gt_test_app/pages/vocabulary_page.dart';

class VocabularyItem extends StatelessWidget {
  VocabularyItem({required this.vocabulary})
      : super(key: ObjectKey(vocabulary));

  final Vocabulary vocabulary;

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
                vocabulary.mainWord,
                style: const TextStyle(color: Colors.black, fontSize: 25),
              ),
              Text(
                vocabulary.associateWord,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
        IconButton(
          iconSize: 25,
          icon: const Icon(
            Icons.edit,
          ),
          alignment: Alignment.topLeft,
          onPressed: () {},
        ),
      ]),
      //subtitle: Text(vocabulary.associateWord, style: const TextStyle(color: Colors.black, fontSize: 15)),
    );
  }
}
