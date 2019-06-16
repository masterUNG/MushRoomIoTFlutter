import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class ShowServic extends StatefulWidget {
  @override
  _ShowServicState createState() => _ShowServicState();
}

class _ShowServicState extends State<ShowServic> {
  // Explicit
  String url1 =
          'https://thingspeak.com/channels/437885/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line',
      url2 =
          'https://thingspeak.com/channels/662286/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15',
      url3 =
          'https://thingspeak.com/channels/437885/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line',
      url4 =
          'https://thingspeak.com/channels/662286/charts/2?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15';
  int fogInt, fanInt, lightInt, cuTemp, cuHumi;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  FirebaseDatabase firebaseDatabaseHumiTemp = FirebaseDatabase.instance;
  Map<dynamic, dynamic> map;
  Map<dynamic, dynamic> mapCu;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String nameLogin = "", uidString, phone;

  @override
  void initState() {
    super.initState();
    getValueFromFirebase();
    getCurrentHumiTempValue();
    findUidLogin();
  }

  void getValueFromFirebase() async {
    DatabaseReference databaseReference =
        await firebaseDatabase.reference().child('IoT').once().then((objValue) {
      map = objValue.value;
      setState(() {
        fogInt = map['Fog'];
        fanInt = map['Fan'];
        lightInt = map['Light'];
        print('fog = $fogInt, fan = $fanInt,light=$lightInt');
      });
    });
  }

  void editFirebase(String nodeString, int value) async {
    print('node ==>$nodeString');
    map['$nodeString'] = value;
    await firebaseDatabase.reference().child('IoT').set(map).then((objValue) {
      print('$nodeString Success');
      getValueFromFirebase();
    }).catchError((objValue) {
      String error = objValue.message;
      print('error ==>$error');
    });
  }

  void getCurrentHumiTempValue() async {
    DatabaseReference databaseReferenceHumiTemp = await firebaseDatabaseHumiTemp
        .reference()
        .child('Current')
        .once()
        .then((objValue) {
      mapCu = objValue.value;
      setState(() {
        cuHumi = mapCu['Cu_Humi'];
        cuTemp = mapCu['Cu_Temp'];
        print('Cu Humi = $cuHumi,Cu Temp = $cuTemp');
      });
    });
  }

  // Method
  Widget showGraph(String urlString) {
    return WebView(
      initialUrl: urlString,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  Widget showCuTemp() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        child: Text(
          'Current Temp: $cuTemp C   ',
          style: TextStyle(
            color: Colors.orange[500],
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  Widget showCuHumi() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        child: Text(
          'Current Humidity: $cuHumi %',
          style: TextStyle(
            color: Colors.blue[700],
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  Widget showPanal(String labelString, int textInt) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            '$textInt',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blue[700],
            ),
          ),
          RaisedButton(
            color: Colors.blue[700],
            textColor: Colors.white,
            child: Text(labelString),
            onPressed: () {
              int valueInt = 0;
              if (labelString == 'Fog') {
                valueInt = fogInt + 1;
                if (valueInt == 2) {
                  valueInt = 0;
                }
              } else if (labelString == 'Fan') {
                valueInt = fanInt + 1;
                if (valueInt == 2) {
                  valueInt = 0;
                }
              } else if (labelString == 'Light') {
                valueInt = lightInt + 1;
                if (valueInt == 2) {
                  valueInt = 0;
                }
              } else {}
              editFirebase(labelString, valueInt);
            },
          )
        ],
      ),
    );
  }

  Widget showThinkSpeak(String urlString) {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        height: 200.0,
        child: showGraph(urlString),
      ),
    );
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

  Widget mySizeBox() {
    return SizedBox(
      width: 10.0,
      height: 10.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Environment'),
        actions: <Widget>[
          signOutButton(),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              center: Alignment(0, -1),
              colors: [
                Colors.white,
                Colors.green[300],
              ],
              radius: 1.5),
        ),
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 10.0,
                top: 15.0,
                bottom: 15,
              ),
              child: Row(
                children: <Widget>[
                  showCuTemp(),
                  showCuHumi(),
                ],
              ),
            ),
            Container(
              width: 240.0,
              child: Row(
                children: <Widget>[
                  showPanal('Fog', fogInt),
                  showPanal('Fan', fanInt),
                  showPanal('Light', lightInt),
                  mySizeBox(),
                ],
              ),
            ),
            showThinkSpeak(url1),
            mySizeBox(),
            showThinkSpeak(url2),
            mySizeBox(),
            showThinkSpeak(url3),
            mySizeBox(),
            showThinkSpeak(url4)
          ],
        ),
      ),
    );
  }
}
