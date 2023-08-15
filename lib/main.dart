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
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: const LoginPage(),
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        '/VP': (context) => const VocabularyPage(),
        '/TP': (context) => const TestPage(),
        '/SP': (context) => const SettingPage(),
        '/AP': (context) => const AboutMePage()
      },
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/landspace.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children:[
                Text('Menu',
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
                      color: Colors.white
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('收藏單字',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/VP');
            },
          ),
          ListTile(
            title: const Text('測驗',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/TP');
            },
          ),
          ListTile(
            title: const Text('設定',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/SP');
            },
          ),
          ListTile(
            title: const Text('關於我',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/AP');
            },
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context,height) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("${"垃圾量 " + height}%"),
    actions: [
      ElevatedButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          }
      ),
    ],
  );

  // Show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}