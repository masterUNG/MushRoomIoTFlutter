import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //Explcit
  double amount = 180.0;
  double size = 250.0;
  //Method
  Widget emailTextFormField() {
    return Container(margin:EdgeInsets.only(top: 10.0),
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email: ',
            hintText: 'you@email.com',
          ),
        ),
      ),
    );
  }
  
  Widget passwordTextFormField() {
    return Container(margin:EdgeInsets.only(top: 10.0),
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password: ',
            hintText: 'More 6 Charactor',
          ),
        ),
      ),
    );
  }

  Widget showName() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Text(
        'MushRoom Farm IoT',
        style: TextStyle(
            fontSize: 30.0,
            color: Colors.orange[500],
            fontWeight: FontWeight.bold,
            fontFamily: 'GloriaHallelujah'),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: amount,
      height: amount,
      child: Image.asset('images/logo.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        alignment: Alignment(0, -1),
        child: Column(
          children: <Widget>[showLogo(),showName(), emailTextFormField(),passwordTextFormField()],
        ),
      ),
    );
  }
}
