import 'package:flutter/material.dart';
import 'package:flutterdatabaseexample/pojo/Note.dart';
import 'package:flutterdatabaseexample/utils/Constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static var _databaseHelper;
  var _database;
  var TABLE_NAME = 'table_name';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
    }
    return _database;
  }

  Future<Database> initializedDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = directory.path + 'notes.db';

    /// create the database

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return notesDatabase;
  }

  void _createDatabase(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $TABLE_NAME($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TITLE TEXT, $DESCRIPTION TEXT, $PRIORITY INTEGER, $DATE TEXT)');
  }

  /// Fetch Operation: Get all the notes from the database
  ///
  ///

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    var database = await this.database;
    //var result = await database.rawQuery('SELECT * FROM $TABLE_NAME order by ${PRIORITY} ASC');

    var result = await database.query(TABLE_NAME, orderBy: '$PRIORITY ASC');
    return result;
  }

  /// Insert Operation : Insert a Note object to database
  ///

  Future<int> insertNote(Note note) async {
    var database = await this.database;
    var result = database.insert(TABLE_NAME, note.toMap());
    return result;
  }

  /// Update Operation : Update a Note object to database

  Future<int> updateNote(Note note) async {
    var database = await this.database;
    var result = database.update(TABLE_NAME, note.toMap(),
        where: '$ID = ?', whereArgs: [note.id]);
    return result;
  }

  /// Delete Operation : Delete a object from database

  Future<int> deleteNote(Note note) async {
    var database = await this.database;
    var result = await database
        .delete(TABLE_NAME, where: '$ID = ?', whereArgs: [note.id]);
    return result;
  }

  /// Get Number of Note objects in database

  Future<int> getCount() async {
    var database = await this.database;
    List<Map<String, dynamic>> x =
        database.rawQuery('SELECT COUNT * from $TABLE_NAME')
            as List<Map<String, dynamic>>;
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    var noteList = List<Note>();
    for (var item in noteMapList) {
      noteList.add(Note.fromMapObjectToNoteObject(item));
    }

    return noteList;
  }
}
