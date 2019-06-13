import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  String nameLogin = "", uidString, phone;

  // Method
  @override
  void initState() {
    super.initState();
    findUidLogin();
  }

  void findUidLogin() async {
    await firebaseAuth.currentUser().then((objValue) {
      uidString = objValue.uid.toString().trim();
      print('uidString ==> $uidString');
      findNameLogin();
    });
  }

  void findNameLogin() async {
    await firebaseDatabase
        .reference()
        .child('User')
        .child(uidString)
        .once()
        .then((DataSnapshot dataSnapshop) {
      String response =
          dataSnapshop.value.toString(); //get all data from firebase
      print('Respose = $response');

      Map<dynamic, dynamic> map = dataSnapshop.value; //get a data
      setState(() {
        nameLogin = map['Name']; // get name
      });
      phone = map['Phone'];
      print('Namelogin = $nameLogin');
      print('Phone = $phone');
    });
  }

  Widget showTitle() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text('My Service'),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'User:$nameLogin ',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        ],
      ),
    );
  }

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
        title: showTitle(),
        actions: <Widget>[signOutButton()],
      ),
      body: Text('body'),
    );
  }
}
