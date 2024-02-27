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
        '/': (context) => AuthPage(),
        '/VP': (context) => VocabularyPage(
              text: '',
              onTap: () {},
            ),
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

class BurgerDrawerWidget extends StatefulWidget {
  //final Function onTap;
  const BurgerDrawerWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BurgerDrawerWidget();
}

class _BottomAppBarWidget extends State<BottomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300], // 設定整個底部區域的背景顏色
      child: BottomAppBar(
        color: Colors.grey[300], // 使 BottomAppBar 背景透明
        elevation: 0, // 取消陰影
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.book_outlined,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/VP');
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.drive_file_rename_outline_outlined,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/TP');
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/SP');
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.account_box,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/AP');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BurgerDrawerWidget extends State<BurgerDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[800],
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey[800]),
            child: const Stack(
              children: [
                Text(
                  'Menu',
                  textAlign: TextAlign.center,
                  strutStyle: StrutStyle(
                    fontSize: 100,
                    leading: 0,
                    height: 1.1,
                    forceStrutHeight: true,
                  ),
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.access_alarms),
            title: const Text(
              '首頁',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
            onTap: () {
              //Navigator.popAndPushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text(
              '陽明山步道',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            onTap: () {
              //Navigator.popAndPushNamed(context, '/YM');
            },
          ),
          ListTile(
            title: const Text(
              '合歡山步道',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
            onTap: () {
              //Navigator.popAndPushNamed(context, '/HH');
            },
          ),
          ListTile(
            title: const Text(
              '雪山步道',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
            onTap: () {
              //Navigator.popAndPushNamed(context, '/SM');
            },
          ),
        ],
      ),
    );
  }
}
