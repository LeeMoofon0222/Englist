import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting",
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode),
                  title: const Text('Dark mode', style: TextStyle(fontWeight: FontWeight.w600)),
                  value: Provider.of<ThemeNotifier>(context).isDarkMode,
                  onChanged: (value) {
                    Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.blue),
              title: const Text('App Version', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('v1.0.1 (Build 3)'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Latest',
                  style: TextStyle(color: Colors.green[800], fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (FirebaseAuth.instance.currentUser != null)
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Account', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(FirebaseAuth.instance.currentUser?.email ?? 'Logged in'),
                trailing: TextButton(
                  onPressed: () => signUserOut(context),
                  child: const Text('Logout', style: TextStyle(color: Colors.red)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
