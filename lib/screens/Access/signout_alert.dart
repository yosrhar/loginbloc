
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginbloc/Authentification/repositories/auth/auth_repository.dart';
import 'package:loginbloc/screens/Access/welcome_screen.dart';

class SignoutAlert extends StatefulWidget {
  const SignoutAlert({super.key});

  @override
  State<SignoutAlert> createState() => _SignoutAlertState();
}

class _SignoutAlertState extends State<SignoutAlert> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      // title: Text("Success"),
      actions: [
        CupertinoDialogAction(onPressed: () {}, child: Text("Back")),
        CupertinoDialogAction(
            onPressed: () async {
              await AuthRepository().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
            child: Text("Logout")),
      ],
      content: Text("Do you want to Logout?"),
    );
  }
}
