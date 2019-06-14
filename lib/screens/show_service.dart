import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowServic extends StatefulWidget {
  @override
  _ShowServicState createState() => _ShowServicState();
}

class _ShowServicState extends State<ShowServic> {
  // Explicit
  String url1 =
      'https://thingspeak.com/channels/437885/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15';
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

  Widget showPanal(String labelString, String valueString) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(valueString),
          RaisedButton(
            child: Text(labelString),
            onPressed: () {},
          )
        ],
      ),
    );
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
                  showPanal('Fog', '0'),
                  showPanal('Fan', '0'),
                  showPanal('Light', '0')
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
