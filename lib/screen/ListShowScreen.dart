import 'package:flutter/material.dart';
import 'package:flutterdatabaseexample/pojo/Note.dart';
import 'package:flutterdatabaseexample/utils/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

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
  var noteList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

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
          navigateToDetails(Note('' , '' , 2),'Add Note');
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

        debugPrint('${this.noteList[position].priority}');
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
              backgroundColor:getPriorityColor(this.noteList[position].priority),

              child: getPriorityIcon(this.noteList[position].priority),
            ),
            onTap: () {
              navigateToDetails(this.noteList[position],'Edit Note');
              debugPrint('Item Click');
            },

          ),
        );
        return cardDesign;
      },
    );
    return myList;
  }

  void navigateToDetails(Note note , var title) async {
   var result =  await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(note, title);
    }));

   if(result){
     updateListView();
   }
  }

  void _delete(BuildContext context, Note note) async {
    debugPrint('note id ${note.id}');
    var result = await databaseHelper.deleteNote(note);
    if (result != 0) {
      _showSnackBar(context, 'Note deleted successfully');
      updateListView();
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

  void updateListView(){
    final Future<Database> db = databaseHelper.initializedDatabase();
    db.then((value){
      Future<List<Note>> list = databaseHelper.getNoteList();
      list.then((value){
        setState(() {
          this.noteList = value;
          this.count = noteList.length;
        });
      });
    });
  }
}
