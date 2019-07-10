import 'package:flutter/material.dart';
import 'package:mushroom_iot_rpc/screens/my_service.dart';
import 'package:mushroom_iot_rpc/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //Explcit
  double amount = 180.0;
  double size = 250.0;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance; //object
  final formKey = GlobalKey<FormState>(); //store email and password
  final scaffoldKey = GlobalKey<ScaffoldState>(); //store stateful all screen
  String emailString, passwordString;

  //Method
  void showSnackBar(String messageString) {
    //show data when error
    SnackBar snackBar = SnackBar(
      content: Text(messageString),
      duration: Duration(seconds: 7), //adjust time to show
      backgroundColor: Colors.orange[500], //bg color
      action: SnackBarAction(
        label: 'Close',textColor: Colors.blue[400],
        onPressed: () {},
      ), 
    );
    scaffoldKey.currentState.showSnackBar(snackBar); //show error snackbar
  }

  //this method doing first
  @override
  void initState() {
    super.initState();
    // checkStatus(context);
  }

  void checkStatus(BuildContext context) async {
    FirebaseUser firebaseUser =
        await firebaseAuth.currentUser(); //Stay login firebase have value
    print('User=');
    print(firebaseUser.toString());
    if (firebaseUser != null) {
      //  Move to MyService
      moveToMyService(context);
    }
  }

  void moveToMyService(BuildContext context) {
    var myServiceRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context)
        .pushAndRemoveUntil(myServiceRoute, (Route<dynamic> route) => false);
  }

  Widget mySizeBox() {
    return SizedBox(
      width: 10.0,
      height: 15.0,
    );
  }

  Widget signInButton(BuildContext context) {
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
        onPressed: () {
          if (formKey.currentState.validate()) {
            //if validate true
            formKey.currentState.save(); //doing all onsave
            checkAuthen(context);
          }
        },
      ),
    );
  }

  void checkAuthen(BuildContext context) async {
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((objValue) {
          moveToMyService(context);
        })
        .catchError((objValue) {
      String error = objValue.message;
      print('error => $error');
      showSnackBar(error);
    });
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
            labelStyle: TextStyle(color: Colors.orange[500]),
          ),
          validator: (String value) {
            if (checkSpace(value)) {
              return 'Please Type Email';
            }
          },
          onSaved: (String value) {
            emailString = value;
          },
        ),
      ),
    );
  }

  bool checkSpace(String value) {
    //check space input from email and password
    bool result = false;
    if (value.length == 0) {
      // Have space
      result = true;
    }
    return result;
  }

  Widget passwordTextFormField() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password: ',
            hintText: 'More 8 Charactor',
            labelStyle: TextStyle(color: Colors.orange[500]),
          ),
          validator: (String value) {
            if (checkSpace(value)) {
              return 'Password Emty';
            }
          },
          onSaved: (String value) {
            passwordString = value;
          },
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
      key: scaffoldKey, //watch all screen
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
        child: Form(
          key: formKey,
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
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      signInButton(context),
                      mySizeBox(),
                      //signUpButton(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
