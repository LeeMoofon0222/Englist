import 'package:flutter/material.dart';
import 'pages/loginpage.dart';

void main() {
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
        '/': (context) => LoginPage(),
        '/CP': (context) => const CollectPage(),
        '/TP': (context) => const TestPage(),
        '/SP': (context) => const SettingPage(),
        '/AP': (context) => const AboutMePage()
      },
    );
  }
}

class CollectPage extends StatelessWidget {
  const CollectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("收藏單字"),
        backgroundColor: Colors.lightBlueAccent[900],
      ),
      drawer: const MyDrawer(),
      backgroundColor: Colors.blue,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
      );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('測驗'),
        backgroundColor: Colors.green[900],
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/images/mountain.jpg'),
            const Positioned(
              bottom: 545,
              right: 255,
              child: Text(
                "步道人數:312人",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 85,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.yellow[800]),
                onPressed: () {
                  showAlertDialog(context,"73");
                },
              ),
            ),
            Positioned(
              bottom: 398,
              right: 60,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.red[600]),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"94");
                },
              ),
            ),
            Positioned(
              bottom: 140,
              right: 200,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"12");
                },
              ),
            ),
            Positioned(
              bottom: 435,
              right: 215,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.yellow[800]),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"66");
                },
              ),
            ),
            Positioned(
              bottom: 35,
              right: 65,
              child: IconButton(
                icon: const Icon(Icons.wc,color: Colors.pinkAccent,size: 30),
                onPressed: () {
                },
              ),
            ),
            Positioned(
              bottom: 190,
              right: 200,
              child: IconButton(
                icon: const Icon(Icons.wc,color: Colors.pinkAccent,size: 30),
                onPressed: () {
                },
              ),
            ),
            Positioned(
              bottom: 395,
              right: 40,
              child: IconButton(
                icon: const Icon(Icons.wc,color: Colors.pinkAccent,size: 30),
                onPressed: () {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        backgroundColor: Colors.green[900],
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/images/SPmountain.jpg'),
            const Positioned(
              bottom: 0,
              right: 20,
              child: Text(
                "步道人數:36人",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),
              ),
            ),
            Positioned(
              bottom: 180,
              right: 292,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.yellow[800]),
                onPressed: () {
                  showAlertDialog(context,"56");
                },
              ),
            ),
            Positioned(
              bottom: 325,
              right: 310,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"9");
                },
              ),
            ),
            Positioned(
              bottom: 180,
              right: 150,
              child: IconButton(
                icon: const Icon(Icons.wc,color: Colors.pinkAccent,size: 30),
                onPressed: () {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('關於我'),
        backgroundColor: Colors.green[900],
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/images/APmountain.jpg'),
            const Positioned(
              bottom: 0,
              right: 15,
              child: Text(
                "步道人數:79人",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              right: 36,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.yellow[800]),
                onPressed: () {
                  showAlertDialog(context,"70");
                },
              ),
            ),
            Positioned(
              bottom: 280,
              right: 290,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.red[600]),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"90");
                },
              ),
            ),
            Positioned(
              bottom: 145,
              right: 230,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"11");
                },
              ),
            ),
            Positioned(
              bottom: 210,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.wc,color: Colors.pinkAccent,size: 30),
                onPressed: () {
                },
              ),
            ),
            Positioned(
              bottom: 260,
              right: 320,
              child: IconButton(
                icon: const Icon(Icons.wc,color: Colors.pinkAccent,size: 30),
                onPressed: () {
                },
              ),
            ),
          ],
        ),
      ),
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
              Navigator.popAndPushNamed(context, '/CP');
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

//Homepage List


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