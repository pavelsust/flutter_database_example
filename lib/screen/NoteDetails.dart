import 'package:flutter/material.dart';
import 'package:flutterdatabaseexample/pojo/Note.dart';
import 'package:flutterdatabaseexample/utils/DatabaseHelper.dart';
import 'package:intl/intl.dart';

class NoteDetails extends StatefulWidget {
  final title;
  Note note;

  NoteDetails(this.note, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteDetails(this.note, this.title);
  }
}

class _NoteDetails extends State<NoteDetails> {
  var _prority = ['High', 'Low'];
  var dropDownItemValue = '';
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var title;
  Note note;
  var databaseHelper = DatabaseHelper();

  _NoteDetails(this.note, this.title);
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownItemValue = _prority[0];
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.title;

    titleController.text = this.note.title;
    descriptionController.text = this.note.description;


    return WillPopScope(
      onWillPop: () {
        navigateToLastScreen();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                DropdownButton<String>(
                  items: _prority.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: getPriorityAsString(note.priority),
                  onChanged: (String newValue) {
                    setState(() {
                      updateProrityToint(newValue);
                    });
                  },
                ),

                /// this is for title section
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: titleController,
                        // ignore: missing_return
                        validator: (String value){
                          if(value.isEmpty){
                            return 'Please enter title';
                          }
                        },
                        style: TextStyle(fontSize: 16, color: textStyle.color),
                        onChanged: (value) {
                          updateTitle();
                        },
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: textStyle,
                          hintText: 'title',
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 13
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    )),

                /// this is for description section
                ///
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Container(
                      child: TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return 'Please enter description';
                          }
                        },
                        keyboardType: TextInputType.text,
                        controller: descriptionController,
                        style: TextStyle(fontSize: 16, color: textStyle.color),
                        onChanged: (value) {
                          updateDescription();
                        },
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: textStyle,
                          hintText: 'description',
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 13
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    )),

                /// This section is for saved button
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                              height: 45,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text(
                                  'Save',
                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                  textScaleFactor: 1.5,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if(_formKey.currentState.validate()){
                                      _save();
                                    }
                                  });
                                },
                              ),
                            )),
                        Container(width: 5),

                        /// this section is for delete button
                        Expanded(
                            child: Container(
                              height: 45,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text(
                                  'Delete',
                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                  textScaleFactor: 1.5,
                                ),
                                onPressed: () {
                                  setState(() {
                                    debugPrint('Delete Button Clicked');
                                    _delete();
                                  });
                                },
                              ),
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToLastScreen() {
    Navigator.pop(context , true);
  }

// String priority to the form of integer

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _prority[0]; // high;
        break;

      case 2:
        priority = _prority[1]; // Low
        break;
    }

    return priority;
  }

  // convert string to int from the dropdown button

  void updateProrityToint(var value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

// update our title
  void updateTitle() {
    note.title = titleController.text;
  }

// update our description
  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    navigateToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    var result;
    if (note.id != null) {
      result = await databaseHelper.updateNote(note);
    } else {
      result = await databaseHelper.insertNote(note);
    }

    if (result != 0) {
      // success
      _showAlertDialog('Status', 'Note saved successfully');
    } else {
      // failed
      _showAlertDialog('Status', 'Problem saving Note');
    }
  }

  void _showAlertDialog(var title, var message) {
    var alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _delete() async {
    // case 1: if user is trying to delete the New Note
    // he comes in the detailed page by pressing FAB button

    navigateToLastScreen();

    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    var result = await databaseHelper.deleteNote(note);
    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note deleted Successfully');
    } else {
      // error
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }

  }
}
