import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginbloc/screens/Access/signout_alert.dart';
import 'package:provider/provider.dart';
import '../provider.dart/user_provider.dart';

class mobileScreenLayout extends StatefulWidget {

  const mobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<mobileScreenLayout> createState() => _mobileScreenLayoutState();
}

class _mobileScreenLayoutState extends State<mobileScreenLayout> {
  void showLogoutAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return SignoutAlert();
      },
    );
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
     Column(
       children: [
         Text('Homescreen'),
        ElevatedButton(
            onPressed: () {
              showLogoutAlert();  
            },
            child: Text('Show Logout Alert'),
          ),
       ],
     ),
     
    );
  }
}
