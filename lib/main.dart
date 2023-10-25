import 'package:flutter/material.dart';
import 'package:gt_test_app/pages/auth_page.dart';
import 'pages/aboutme_page.dart';
import 'pages/setting_page.dart';
import 'pages/vocabulary_page.dart';
import 'pages/test_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: const LoginPage(),
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        '/VP': (context) => VocabularyPage(text: ''),
        '/TP': (context) => const TestPage(),
        '/SP': (context) => const SettingPage(),
        '/AP': (context) => const AboutMePage()
      },
    );
  }
}

class BottomAppBarWidget extends StatefulWidget {

  //final Function onTap;
  const BottomAppBarWidget({super.key});


  @override
  State<StatefulWidget> createState() => _BottomAppBarWidget();
}

class _BottomAppBarWidget extends State<BottomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],  // 設定整個底部區域的背景顏色
      child: BottomAppBar(
        color: Colors.transparent, // 使 BottomAppBar 背景透明
        elevation: 0, // 取消陰影
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.book_outlined, size: 30,),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/VP');
                },
              ),
              IconButton(
                icon: const Icon(Icons.drive_file_rename_outline_outlined, size: 30,),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/TP');
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings, size: 30,),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/SP');
                },
              ),
              IconButton(
                icon: const Icon(Icons.account_box, size: 30,),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/AP');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
