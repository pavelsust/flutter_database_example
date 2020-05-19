import 'package:flutter/material.dart';

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
      ),
      body: getList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint('Floating item click');
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
            onTap: (){
              debugPrint('Item Click');
            },
          ),
        );
        return cardDesign;
      },
    );
    return myList;
  }
}
