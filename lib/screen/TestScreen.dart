import 'package:flutter/material.dart';
import 'package:flutterdatabaseexample/pojo/Note.dart';

class TestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestScreen();
  }
}

class _TestScreen extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {

    final note = ModalRoute.of(context).settings.arguments as Note;


    return Scaffold(
      appBar: AppBar(
        title: Text('${note.title}'),
      ),
      body: Center(
        child: Text(
          '${note.name}',
          style: TextStyle(fontSize: 14, color: Colors.yellowAccent),
        ),
      ),
    );
  }
}
