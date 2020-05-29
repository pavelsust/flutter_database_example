import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {
  var title;

  NoteDetails(this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteDetails(title);
  }
}

class _NoteDetails extends State<NoteDetails> {
  var _prority = ['Normal', 'High'];
  var dropDownItemValue = '';

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var title;

  _NoteDetails(this.title);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownItemValue = _prority[0];
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.title;

    return WillPopScope(
      onWillPop: () {
        navigateToLastScreen();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Padding(
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
                value: dropDownItemValue,
                onChanged: (String newValue) {
                  setState(() {
                    this.dropDownItemValue = newValue;
                  });
                },
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: titleController,
                      style: TextStyle(fontSize: 16, color: textStyle.color),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        hintText: 'title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: descriptionController,
                      style: TextStyle(fontSize: 16, color: textStyle.color),
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textStyle,
                        hintText: 'description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  )),
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
                              debugPrint('Save Button Clicked');
                            });
                          },
                        ),
                      )),
                      Container(width: 5),
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
    );
  }

  void navigateToLastScreen() {
    Navigator.pop(context);
  }
}
