import 'package:flutter/material.dart';
import 'package:flutterdatabaseexample/screen/ListShowScreen.dart';
import 'package:flutterdatabaseexample/screen/NoteDetails.dart';


void main() => runApp(MyFlutterApp());

class MyFlutterApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var materialApp = MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: NoteDetails()
    );

    return materialApp;
  }

}