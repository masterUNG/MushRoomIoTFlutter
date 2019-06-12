import 'package:flutter/material.dart';
import 'package:mushroom_iot_rpc/screens/authen.dart';
import 'package:mushroom_iot_rpc/screens/register.dart';

main() {
  runApp(MyAppd()); //run myapps
}

class MyAppd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authen(), //home screen
    );
  }
}
