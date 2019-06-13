import 'package:flutter/material.dart';
import 'package:mushroom_iot_rpc/screens/authen.dart';
import 'package:mushroom_iot_rpc/screens/register.dart';
import 'package:flutter/services.dart';

main() {
  runApp(MyAppd()); //run myapps
}

class MyAppd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);//adjust screen portal
    return MaterialApp(
      debugShowCheckedModeBanner: false, //don't show debug on screen
      home: Authen(), //home screen
    );
  }
}
