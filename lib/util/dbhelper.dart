import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';

class DbHelper {

  static String tblDocs = "docs";

  String docId = "id";
  String docTitle = "title";
  String docExpiration = "expiration";

  String fqYear = "fqYear";
  String fqHalfYear = "fqHalfYear";
  String fqQuarter = "fqQuarter";
  String fqMonth = "fqMonth";

  // singleton
  static final DbHelper _dbHelper = DbHelper._internal();

  // Factory constructor - create the internal instance
  DbHelper._internal();


  // the factory returns the singleton
  factory DbHelper() => _dbHelper;

  // db from sqflite property
  static Database _db;

  // create (if its not created yet) and returns the database
  Future<Database> get db async {
    if (_db == null)
      _db = await initializeDb();

      return _db;
  }

  // create the database
  // this "Future" class is very similar to a promise of javascript
  Future<Database> initializeDb() async {
    Directory d = await getApplicationDocumentsDirectory();
    String p = d.path + "/docexpire.db";
    var db = await openDatabase(p, version: 1, onCreate: _createDb);
    return db;
  }

  // method execute when the database is created
  void _createDb(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $tblDocs($docId INTEGER PRIMARY KEY, $docTitle TEXT, "
      + "$docExpiration TEXT, " +
      "$fqYear INTEGER, $fqHalfYear INTEGER, $fqQuarter INTEGER, " +
      "$fqMonth INTEGER)"
    );
  }

}