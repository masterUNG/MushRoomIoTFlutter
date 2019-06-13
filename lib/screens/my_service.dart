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

  Widget temHeight() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Temp Height:',
          helperText: 'องศา C',
        ),
      ),
    );
  }

  Widget temLow() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Temp Low:',
          helperText: 'องศา C',
        ),
      ),
    );
  }

  Widget humidityHeight() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Humidity Height:',
          helperText: '% ความชื้น',
        ),
      ),
    );
  }

  Widget humidityLow() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Humidity Low:',
          helperText: '% ความชื้น',
        ),
      ),
    );
  }

  Widget suitableHumidity() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Suitable Humidity:',
          helperText: '% ความชื้น',
        ),
      ),
    );
  }

  Widget suitableTem() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Suitable Tem:',
          helperText: 'อวศา C',
        ),
      ),
    );
  }

  Widget row1() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 300.0,
        child: Row(
          children: <Widget>[temLow(), temHeight()],
        ),
      ),
    );
  }

  Widget row2() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 300.0,
        child: Row(
          children: <Widget>[humidityLow(), humidityHeight()],
        ),
      ),
    );
  }

  Widget row3() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 300.0,
        child: Row(
          children: <Widget>[suitableHumidity(), suitableTem()],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showTitle(),
        actions: <Widget>[signOutButton()],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[row1(), row2(), row3()],
        ),
      ),
    );
  }
}
