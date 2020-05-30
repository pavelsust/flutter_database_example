import 'package:flutter/material.dart';
import 'package:flutterdatabaseexample/pojo/Note.dart';
import 'package:flutterdatabaseexample/utils/DatabaseHelper.dart';

import 'NoteDetails.dart';

class ListShowScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListShowScreen();
  }
}

class _ListShowScreen extends State<ListShowScreen> {
  var count = 0;
  var databaseHelper = DatabaseHelper();
  var noteList = List<Note>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (noteList == null) {
      noteList = List<Note>();
    }
  }

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
          /*
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TestScreen(),
          settings: RouteSettings(arguments: Note('pavel' , 'pavel'))), (route) => false);
           */
          navigateToDetails('Add Note');
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
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey),
            onTap: (){
                _delete(context, this.noteList[position]);
            },),


            title: Text(this.noteList[position].title, style: textStyle),
            subtitle:
                Text(this.noteList[position].description, style: textStyle),
            leading: CircleAvatar(
              backgroundColor:
                  getPriorityColor(this.noteList[position].priority),
              child: Icon(this.noteList[position].priority),
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

  void navigateToDetails(var title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(title);
    }));
  }

  void _delete(BuildContext context, Note note) async {
    var result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note deleted successfully');
    }
  }

  void _showSnackBar(BuildContext context, var message) {
    var snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(var priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }
}
