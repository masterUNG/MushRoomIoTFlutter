import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:mushroom_iot_rpc/screens/show_service.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final formKey = GlobalKey<FormState>();
  String nameLogin = "", uidString, phone;
  int tempLow, tempHight, humiLow, humiHight, suitHumi, suitTem;

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
            child: Text('Environment Setting'),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '$nameLogin ',
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

  bool checkSpace(String value) {
    bool result = false;
    if (value.length == 0) {
      result = true;
    }
    return result;
  }

  Widget temHeight() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.blue[700],
              ),
              borderRadius: BorderRadius.circular(25.0)),
          labelText: 'Temp Height:',
          helperText: 'องศา C',
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          tempHight = valueInt;
        },
      ),
    );
  }

  Widget temLow() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.green[500],
              ),
              borderRadius: BorderRadius.circular(25.0)),
          labelText: 'Temp Low:',
          helperText: 'องศา C',
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          tempLow = valueInt;
        },
      ),
    );
  }

  Widget humidityHeight() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.orange[500],
              ),
              borderRadius: BorderRadius.circular(25.0)),
          labelText: 'Humidity Height:',
          helperText: '% ความชื้น',
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          humiHight = valueInt;
        },
      ),
    );
  }

  Widget humidityLow() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.yellow[600]),
              borderRadius: BorderRadius.circular(25.0)),
          labelText: 'Humidity Low:',
          helperText: '% ความชื้น',
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          humiLow = valueInt;
        },
      ),
    );
  }

  Widget suitableHumidity() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.red[500]),
              borderRadius: BorderRadius.circular(25.0)),
          labelText: 'Suitable Humidity:',
          helperText: '% ความชื้น',
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          suitHumi = valueInt;
        },
      ),
    );
  }

  Widget suitableTem() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.purple[600]),
              borderRadius: BorderRadius.circular(25.0)),
          labelText: 'Suitable Tem:',
          helperText: 'อวศา C',
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          suitTem = valueInt;
        },
      ),
    );
  }

  Widget showText() {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.topCenter,
      child: Text(
        'Setting Data',
        style: TextStyle(color: Colors.blue[600], fontSize: 25.0),
      ),
    );
  }

  Widget row1() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 380.0,
        child: Row(
          children: <Widget>[temLow(), mySizeBox(), temHeight()],
        ),
      ),
    );
  }

  Widget row2() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 380.0,
        child: Row(
          children: <Widget>[humidityLow(), mySizeBox(), humidityHeight()],
        ),
      ),
    );
  }

  Widget row3() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 380.0,
        child: Row(
          children: <Widget>[suitableHumidity(), mySizeBox(), suitableTem()],
        ),
      ),
    );
  }

  Widget sentButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      alignment: Alignment.topCenter,
      child: RaisedButton(
        color: Colors.white,
        child: Text(
          'Sent Data',
          style: TextStyle(color: Colors.blue[700]),
        ),
        onPressed: () {
          print('You Click Sent Button');
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            uploadToFirebase(context);
          }
        },
      ),
    );
  }

  void uploadToFirebase(BuildContext context) async {
    print(
        'TemLow= $tempLow, TemHight = $tempHight, HumLow = $humiLow, HumHight=$humiHight, SuitTem = $suitTem, SuitHum=$suitHumi');
    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoT');
    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> map = dataSnapshot.value;
      print('map = $map');

      map['Temp_Low'] = tempLow;
      map['Temp_High'] = tempHight;
      map['Humidity_Low'] = humiLow;
      map['Humidity_High'] = humiHight;
      map['Suitable_Humi'] = suitHumi;
      map['Suitable_Tem'] = suitTem;

      print('map current = $map');
      sentDataToFirebase(map, context);
    });
  }

  void sentDataToFirebase(Map map, BuildContext context) async {
    await firebaseDatabase.reference().child('IoT').set(map).then((objValue) {
      print('Success');
      var showServiceRoute =
          MaterialPageRoute(builder: (BuildContext context) => ShowServic());
      Navigator.of(context).push(showServiceRoute);
    }).catchError((objValue) {
      String errorString = objValue.message;
    });
  }

  Widget mySizeBox() {
    return SizedBox(
      width: 10.0,
      height: 15.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: showTitle(),
          actions: <Widget>[signOutButton()],
        ),
        body: Container(decoration: BoxDecoration(
          gradient: RadialGradient(
              center: Alignment(0, -1),
              colors: [
                Colors.white,
                Colors.blue[300],
              ],
              radius: 1.5),
        ),
          child: Form(
            key: formKey,
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 30.0),
              child: Column(
                children: <Widget>[
                  showText(),
                  row1(),
                  row2(),
                  row3(),
                  sentButton(context)
                ],
              ),
            ),
          ),
        ));
  }
}
