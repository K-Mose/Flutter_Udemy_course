// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var appBarTitleText = "Appbar Title";

  void onButtonPressed(String newText) {
    setState(() {
      appBarTitleText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text(appBarTitleText)),
      body: Center(
        child: Column(children: [
          ElevatedButton(
              onPressed: () {
                onButtonPressed("new Text1");
              },
              child: Text("Change Text 1")),
          ElevatedButton(
              onPressed: () {
                onButtonPressed("new Text2");
              },
              child: Text("Change Text 1")),
          ElevatedButton(
              onPressed: () {
                onButtonPressed("new Text3");
              },
              child: Text("Change Text 1"))
        ]),
      ),
    ));
  }
}
