import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method
  Widget signOutButton() {
    //sign out buttom
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        signOut();
      },
    );
  }

  void signOut() async {
    await firebaseAuth.signOut().then((objValue) {
      print('Exit');
      exit(0);
    }); //signOut from firebase
    // Exit App
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyService'),
        actions: <Widget>[signOutButton()],
      ),
      body: Text('body'),
    );
  }
}
