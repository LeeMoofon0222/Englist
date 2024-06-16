import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/big_square_tile.dart';
import '../main.dart';


class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  void signUserOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: const Text(
            "Logout?",
            style: TextStyle(
                color: Colors.black, fontSize: 21, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'cancel',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text(
                'yes',
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

  Future<void> _launchURL(String myUrl) async {
    final Uri url = Uri.parse(myUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About me",
            style: TextStyle(color: Colors.white, fontSize: 23)),
        backgroundColor: Colors.grey[800],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () => signUserOut(context),
            icon: const Icon(
              Icons.logout,
              size: 30,
            ),
            color: Colors.white,
          )
        ],
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const BigSquareTile(imagePath: 'lib/images/profile.jpg'),
            const SizedBox(height: 20),
            const Text(
              '李沐風 Moofon',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Hi 👋, I'm Moofon\n\n"
                  " A 19-years-old student in Taiwan\n\n"
                  "🔭 Currently studing in NTUT \n"
                  "(Intelligent Automation Engineering)\n",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey[800],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'CONTACT ME',
                      style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey[800],
                      ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Email: jameslee940222@gmail.com',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Phone: (886) 968933540',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset(
                    'lib/images/facebook.png',
                    height: 50,
                    width: 50,
                  ),
                  iconSize: 20,
                  onPressed: () {_launchURL("https://www.facebook.com/moofon0222");},
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: Image.asset(
                    'lib/images/Instagram.png',
                    height: 50,
                    width: 50,
                  ),
                  iconSize: 20,
                  onPressed: () {_launchURL("https://www.instagram.com/moofon0222/");},
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: Image.asset(
                    'lib/images/github.png',
                    height: 50,
                    width: 50,
                  ),
                  iconSize: 20,
                  onPressed: () {_launchURL("https://github.com/LeeMoofon0222");},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
