import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUserOut extends StatefulWidget {
  final Function(bool) onReturnRegisterChanged;

  const SignUserOut({Key? key, required this.onReturnRegisterChanged})
      : super(key: key);

  @override
  State<SignUserOut> createState() => _SignUserOutState();
}

class _SignUserOutState extends State<SignUserOut> {
  bool returnRegister = false;


  void signUserOut() {
    final user = FirebaseAuth.instance.currentUser;
    if (user?.email != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            title: const Text(
              "確定要登出嗎",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            actions: [
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
                  FirebaseAuth.instance.signOut();
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
        },
      );

    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            title: const Text(
              "確定要登出嗎，資料將遺失 登入以儲存資料",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    returnRegister = true;
                  });
                },
                child: const Text(
                  '登入',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
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
                  FirebaseAuth.instance.signOut();
                  /*Delete用戶*/
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
        },
      );
    }
    widget.onReturnRegisterChanged(returnRegister);
  }

  bool getReturnRegisterValue() {
    return returnRegister;
  }

  @override
  Widget build(BuildContext context) {
    /*
    if(returnRegister){
      return const RegisterPage(onTap: null);
    }*/
      return IconButton(
        onPressed: signUserOut,
        icon: const Icon(
          Icons.logout,
          size: 30,
        ),
        color: Colors.white,
      );
  }
}
