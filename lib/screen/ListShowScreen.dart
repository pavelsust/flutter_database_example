import 'package:flutter/material.dart';
import 'package:flutterdatabaseexample/pojo/Note.dart';
import 'package:flutterdatabaseexample/screen/TestScreen.dart';

import 'NoteDetails.dart';

class ListShowScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListShowScreen();
  }
}

class _ListShowScreen extends State<ListShowScreen> {
  var count = 0;

  @override
  Widget build(BuildContext context) {
    var listShow = Scaffold(
      appBar: AppBar(
        title: Text('List Show'),
        automaticallyImplyLeading: false,
      ),
      body: getList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TestScreen(),
          settings: RouteSettings(arguments: Note('pavel' , 'pavel'))), (route) => false);
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );

    return listShow;
  }

  ListView getList() {
    var textStyle = Theme.of(context).textTheme.title;

    var myList = ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        var cardDesign = Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            trailing: Icon(Icons.delete, color: Colors.grey),
            title: Text('Dummy Title', style: textStyle),
            subtitle: Text('Dummy Subtitle', style: textStyle),
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),
            onTap: () {
              navigateToDetails('Edit Note');
              debugPrint('Item Click');
            },
          ),
        );
        return cardDesign;
      },
    );
    return myList;
  }

  void navigateToDetails(var title){
    Navigator.push(context,
    MaterialPageRoute(builder: (context){
      return NoteDetails(title);
    }));
  }
}
