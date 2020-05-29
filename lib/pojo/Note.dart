import 'package:flutterdatabaseexample/utils/Constant.dart';

class Note {
  var _id;
  var _title;
  var _description;
  var _date;
  var _priority;

  Note(this._title, this._date, this._priority, [this._description]);

  Note.withId(this._id, this._title, this._date, this._priority,
      [this._description]);

  get priority => _priority;

  set priority(value) {
    if (value >= 1 && value <= 2) {
      _priority = value;
    }
  }

  get date => _date;

  set date(value) {
    _date = value;
  }

  get description => _description;

  set description(value) {
    _description = value;
  }

  get title => _title;

  set title(value) {
    _title = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  /// Convert Note object to Map object

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[ID] = _id;
    map[TITLE] = _title;
    map[DESCRIPTION] = _description;
    map[PRIORITY] = _priority;
    map[DATE] = _date;
    return map;
  }

  /// extract a map object to note object

  Note.fromMapObjectToNoteObject(Map<String, dynamic> map) {
    this._id = map[ID];
    this._title = map[TITLE];
    this._description = map[DESCRIPTION];
    this._priority = map[PRIORITY];
    this._date = map[DATE];
  }
}
