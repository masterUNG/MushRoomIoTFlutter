import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //Explcit
  double amount = 180.0;
  //Method
  Widget showName() {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Text(
        'MushRoom Farm IoT',
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.orange[500],
          fontWeight: FontWeight.bold, fontFamily: 'GloriaHallelujah'
        ),
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70.0),
        alignment: Alignment(0, -1),
        child: Column(
          children: <Widget>[showLogo(), showName()],
        ),
      ),
    );
  }
}
