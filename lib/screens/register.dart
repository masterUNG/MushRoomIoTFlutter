import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>(); //create sending variable
  String nameString, emailString, passwordString, phoneString;

  // Method
  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      iconSize: 36.0,
      onPressed: () {
        print('You Click Upload');
        if (formKey.currentState.validate()) {
          formKey.currentState.save(); //save data from form to variable
          uploadToFirebase();
        }
      },
    );
  }

  void uploadToFirebase() async {
    //async is a thread
    print(
        'Name = $nameString,email = $emailString, pass = $passwordString, phone = $phoneString');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth //waitting for push data to firebase
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((objValue) {
      String uidString = objValue.uid.toString();
      print('uid ==> $uidString');
      uploadValueToDatabase(uidString)
    }).catchError((objValue) {
      String error = objValue.message; //show error
      print('error ==> $error');
    });
  }

  void uploadValueToDatabase(String uid)async{
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    

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
        helperStyle:
            TextStyle(color: Colors.orange[300], fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (value.length == 0) {
          return 'Please Fill Name in Blank';
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
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
        helperStyle:
            TextStyle(color: Colors.orange[300], fontStyle: FontStyle.italic),
      ),
      validator: (String namevalue) {
        if (!((namevalue.contains('@')) && (namevalue.contains('.')))) {
          return 'Wrong Email Format you@email.com';
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
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
        helperStyle:
            TextStyle(color: Colors.orange[300], fontStyle: FontStyle.italic),
      ),
      validator: (String passwordvalue) {
        if (passwordvalue.length <= 7) {
          return 'Minimum Password is 8 Charactor';
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
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
        helperStyle:
            TextStyle(color: Colors.orange[300], fontStyle: FontStyle.italic),
      ),
      validator: (String phonevalue) {
        if (phonevalue.length == 0) {
          return 'Please Fill Phone in Blank';
        }
      },
      onSaved: (String value) {
        phoneString = value.trim();
      },
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
      body: Form(
        key: formKey,
        child: Container(
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
      ),
    );
  }
}
