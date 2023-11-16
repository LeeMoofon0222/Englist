import 'package:flutter/material.dart';
import 'package:gt_test_app/pages/InPage_register_page.dart';
import 'package:gt_test_app/pages/vocabulary_page.dart';

class PageOrRegisterPage extends StatefulWidget {
  const PageOrRegisterPage({Key? key}) : super(key: key);

  @override
  State<PageOrRegisterPage> createState() => _PageOrRegisterPageState();
}

class _PageOrRegisterPageState extends State<PageOrRegisterPage> {
  bool showRegisterPage = false;

  void togglePages(){
    setState(() {
      showRegisterPage = !showRegisterPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showRegisterPage){
      return InpageRegisterPage(onTap: togglePages);
    }
    else{
      return VocabularyPage(text: "", onTap: togglePages);
    }
  }
}
