import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/auth_page.dart';
import 'pages/aboutme_page.dart';
import 'pages/setting_page.dart';
import 'pages/vocabulary_page.dart';
import 'pages/test_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My App',
          theme: themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          initialRoute: '/',
          routes: {
            '/': (context) => AuthPage(),
            '/VP': (context) => VocabularyPage(
              text: '',
              onTap: () {},
            ),
            '/TP': (context) => const TestPage(),
            '/SP': (context) => const SettingPage(),
            '/AP': (context) => const AboutMePage(),
          },
        );
      },
    );
  }
}

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
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
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: ExactAssetImage('lib/images/google.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 8.0,
                  left: 4.0,
                  child: Text(
                    "Menu",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text("About"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.grid_3x3_outlined),
            title: const Text("Products"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text("Contact"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
