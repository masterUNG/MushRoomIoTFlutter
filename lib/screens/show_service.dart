import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class ShowServic extends StatefulWidget {
  @override
  _ShowServicState createState() => _ShowServicState();
}

class _ShowServicState extends State<ShowServic> {
  // Explicit
  String url1 =
      'https://thingspeak.com/channels/437885/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15';
  int fogInt, fanInt, lightInt;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  Map<dynamic, dynamic> map;

  @override
  void initState() {
    super.initState();
    getValueFromFirebase();
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
        child: Text('CuTemp'),
      ),
    );
  }

  Widget showCuHumi() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        child: Text('CuHumi'),
      ),
    );
  }

  Widget showPanal(String labelString, int textInt) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text('$textInt'),
          RaisedButton(
            child: Text(labelString),
            onPressed: () {
              int valueInt =0;
              if (labelString=='Fog') {
                valueInt = fogInt+1;
                if (valueInt==2) {
                  valueInt=0;
                }
              }else if(labelString=='Fan'){
                  valueInt = fanInt+1;
                if (valueInt==2) {
                  valueInt=0;
                }
              }else{
                valueInt = lightInt+1;
                if (valueInt==2) {
                  valueInt=0;
              }
              }
              editFirebase(labelString,valueInt);
            },
          )
        ],
      ),
    );
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

  Widget showThinkSpeak(String urlString) {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        height: 150.0,
        child: showGraph(urlString),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Environment'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            showCuTemp(),
            showCuHumi(),
            Container(
              width: 240.0,
              child: Row(
                children: <Widget>[
                  showPanal('Fog', fogInt),
                  showPanal('Fan', fanInt),
                  showPanal('Light', lightInt)
                ],
              ),
            ),
            showThinkSpeak(url1),
            showThinkSpeak(url1),
            showThinkSpeak(url1),
            showThinkSpeak(url1)
          ],
        ),
      ),
    );
  }
}
