import 'package:flutter/material.dart';
import 'package:mushroom_iot_rpc/screens/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //Explcit
  double amount = 180.0;
  double size = 250.0;

  //Method
  Widget mySizeBox() {
    return SizedBox(
      width: 10.0,
      height: 15.0,
    );
  }

  Widget signInButton() {
    return Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.orange[500],
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.orange[500]),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.orange[500]),
        ),
        onPressed: () {
          print('You Click SignUp');

          // Create Route
          var registerRoute =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(registerRoute);
        },
      ),
    );
  }

  Widget emailTextFormField() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Email: ',
              hintText: 'you@email.com',
              labelStyle: TextStyle(color: Colors.orange[500])),
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Password: ',
              hintText: 'More 6 Charactor',
              labelStyle: TextStyle(color: Colors.orange[500])),
        ),
      ),
    );
  }

  Widget showName() {
    return Container(
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              center: Alignment(0, 0),
              colors: [
                Colors.white,
                Colors.green[300],
              ],
              radius: 1.5),
        ),
        padding: EdgeInsets.only(top: 20.0),
        alignment: Alignment(0, -1),
        child: Column(
          children: <Widget>[
            showLogo(),
            mySizeBox(),
            showName(),
            mySizeBox(),
            emailTextFormField(),
            mySizeBox(),
            passwordTextFormField(),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              alignment: Alignment.center,
              child: Container(
                width: size,
                child: Row(
                  children: <Widget>[
                    signInButton(),
                    mySizeBox(),
                    signUpButton(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
