import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';

import 'package:succintly_flutter_book_app/model/model.dart';

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
    if (_db == null) _db = await initializeDb();

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
        "CREATE TABLE $tblDocs($docId INTEGER PRIMARY KEY, $docTitle TEXT, " +
            "$docExpiration TEXT, " +
            "$fqYear INTEGER, $fqHalfYear INTEGER, $fqQuarter INTEGER, " +
            "$fqMonth INTEGER)");
  }

  // given a doc map it and insert in the tblDocs
  Future<int> insertDoc(Doc doc) async {
    var r;

    Database db = await this.db;

    try {
      r = await db.insert(tblDocs, doc.toMap());
    } catch (e) {
      debugPrint("insertDoc: " + e.toString());
    }

    return r;
  }

  // the the docs that ordering by expiration day
  Future<List> getDocs() async {
    Database db = await this.db;
    var r =
        await db.rawQuery("SELECT * FROM $tblDocs ORDER BY $docExpiration ASC");
    return r;
  }

  Future<List> getDoc(int id) async {
    Database db = await this.db;
    var r = await db.rawQuery(
        "SELECT * FROM $tblDocs WHERE $docId = " + id.toString() + "");
    return r;
  }

  // I can't understand this method... if you have the id why you need to inform the doc expiration
  // date to retrieve the doc?
  Future<List> getDocFromStr(String payload) async {
    List<String> p = payload.split('|');
    if (p.length == 2) {
      Database db = await this.db;
      var r = await db.rawQuery("SELECT * FROM $tblDocs WHERE $docId = " +
          p[0] +
          " AND $docExpiration = '" +
          p[1] +
          "'");
      return r;
    } else {
      return null;
    }
  }

  // return integer - count of the docs in the db
  Future<int> getDocsCount() async {
    Database db = await this.db;
    var r = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tblDocs'));

    return r;
  }

  //get the max id on the db
  Future<int> getMaxId() async {
    Database db = await this.db;

    var r = Sqflite.firstIntValue(
        await db.rawQuery('SELECT MAX(id) FROM $tblDocs'));

    return r;
  }

  // update doc
  Future<int> updateDoc(Doc doc) async {
    var db = await this.db;
    var r = await db
        .update(tblDocs, doc.toMap(), where: "$docId = ?", whereArgs: [doc.id]);
    return r;
  }

  // delete a doc given an id
  Future<int> deleteDoc(int id) async {
    var db = await this.db;
    int r = await db.rawDelete("DELETE FROM $tblDocs WHERE $docId = $id");
    return r;
  }

  // !important : the use of future is to avoid the need of waiting the dabtase operations
  // to be finish to continue app usage
  // [https://dart.dev/codelabs/async-await]

}
