import 'package:flutter/material.dart';

class BoxOfficeItem {
  DateTime date;
  int total;

  BoxOfficeItem({@required this.date, @required this.total});
}

class Person {
  var _id;
  String fullName;
  String avatar;

  Person({this.fullName, this.avatar});

  Person.map(dynamic obj) {
    this.fullName = obj['fullName'];
    this.avatar = obj['avatar'];
  }

  String get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['fullName'] = this.fullName;
    map['avatar'] = this.avatar;

    return map;
  }

  Person.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this.fullName = map['fullName'];
    this.avatar = map['avatar'];
  }
}

class Movie {
  String title;
  String original;
  String kbRef;
  String poster;
  List<String> genres;
  String description;
  List<Person> directors;
  List<Person> actors;
  BoxOfficeItem thursdayRus;
  BoxOfficeItem weekendRus;
  BoxOfficeItem totalRus;
  BoxOfficeItem spectaculars;

  Movie({@required this.title,
    this.original,
    this.kbRef,
    this.poster,
    this.genres,
    this.description,
    this.directors,
    this.actors,
    this.thursdayRus,
    this.weekendRus,
    this.totalRus,
    this.spectaculars});
}

class Note {
  String _id;
  String _title;
  String _description;

  Note(this._id, this._title, this._description);

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._description = obj['description'];
  }

  String get id => _id;

  String get title => _title;

  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
  }
}

class Worker {
  String _id;
  DateTime _lastWorked;

  Worker(this._id, this._lastWorked);

  Worker.map(dynamic obj) {
    this._id = obj['id'];
    this._lastWorked = obj['lastWorked'];
  }

  String get id => _id;

  DateTime get description => _lastWorked;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['lastWorked'] = _lastWorked;

    return map;
  }

  Worker.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._lastWorked = map['lastWorked'];
  }
}

class YearRecord {
  var _id;
  int pos;
  String title;
  int boxOffice;
  int boxOfficeUsd;
  String original;
  String distributor;
  int screens;
  int spectaculars;
  String kbRef;

  YearRecord({@required this.pos,
    @required this.title,
    @required this.boxOffice,
    this.boxOfficeUsd,
    this.original,
    this.distributor,
    this.screens,
    this.spectaculars,
    this.kbRef});

  YearRecord.map(dynamic obj) {
    this.pos = obj['pos'];
    this.title = obj['title'];
    this.boxOffice = obj['boxOffice'];
    this.boxOfficeUsd = obj['boxOfficeUsd'];
    this.original = obj['original'];
    this.distributor = obj['distributor'];
    this.screens = obj['screens'];
    this.spectaculars = obj['spectaculars'];
    this.kbRef = obj['kbRef'];
  }

  String get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['pos'] = this.pos;
    map['title'] = this.title;
    map['boxOffice'] = this.boxOffice;
    map['boxOfficeUsd'] = this.boxOfficeUsd;
    map['original'] = this.original;
    map['distributor'] = this.distributor;
    map['screens'] = this.screens;
    map['spectaculars'] = this.spectaculars;
    map['kbRef'] = this.kbRef;

    return map;
  }

  YearRecord.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this.pos = map['pos'];
    this.title = map['title'];
    this.boxOffice = map['boxOffice'];
    this.boxOfficeUsd = map['boxOfficeUsd'];
    this.original = map['original'];
    this.distributor = map['distributor'];
    this.screens = map['screens'];
    this.spectaculars = map['spectaculars'];
    this.kbRef = map['kbRef'];
  }
}


class WeekendRecord {
  int pos;
  String title;
  int boxOffice;
  String kbRef;

  WeekendRecord({this.pos, this.title, this.boxOffice, this.kbRef});
}

class Thursday {
  String _id;
  String kbRef;
  String title;
  int boxOffice;

  Thursday({this.kbRef, this.title, this.boxOffice});

  Thursday.map(dynamic obj) {
    this.kbRef = obj['kbRef'];
    this.title = obj['title'];
    this.boxOffice = obj['boxOffice'];
  }

  String get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['kbRef'] = this.kbRef;
    map['title'] = this.title;
    map['boxOffice'] = this.boxOffice;

    return map;
  }

  Thursday.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this.kbRef = map['kbRef'];
    this.title = map['title'];
    this.boxOffice = map['boxOffice'];
  }
}

class ThursdayRecord {
  int pos;
  String title;
  int boxOffice;

  ThursdayRecord(this.pos, this.title, this.boxOffice);
}
