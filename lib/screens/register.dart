import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      iconSize: 36.0,
      onPressed: () {},
    );
  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.face,
            color: Colors.blue[500],
            size: 36.0,
          ),
          labelText: 'Name :',
          labelStyle: TextStyle(color: Colors.orange[500]),
          helperText: 'First Name and Last Name',
          helperStyle: TextStyle(
              color: Colors.orange[300], fontStyle: FontStyle.italic)),
    );
  }

  Widget nameEmail() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: Colors.blue[500],
            size: 36.0,
          ),
          labelText: 'Email :',
          labelStyle: TextStyle(color: Colors.orange[500]),
          helperText: 'abce@gmail.com',
          helperStyle: TextStyle(
              color: Colors.orange[300], fontStyle: FontStyle.italic)),
    );
  }

  Widget namePassword() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Colors.blue[500],
            size: 36.0,
          ),
          labelText: 'Password :',
          labelStyle: TextStyle(color: Colors.orange[500]),
          helperText: '8 Charactor',
          helperStyle: TextStyle(
              color: Colors.orange[300], fontStyle: FontStyle.italic)),
    );
  }

  Widget namePhone() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.phone,
            color: Colors.blue[500],
            size: 36.0,
          ),
          labelText: 'Phone :',
          labelStyle: TextStyle(color: Colors.orange[500]),
          helperText: '0891234567',
          helperStyle: TextStyle(
              color: Colors.orange[300], fontStyle: FontStyle.italic)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text('Register'),
        actions: <Widget>[uploadButton()],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 80.0, left: 50.0, right: 50.0),
        child: ListView(
          children: <Widget>[
            nameText(),
            nameEmail(),
            namePassword(),
            namePhone()
          ],
        ),
      ),
    );
  }
}
