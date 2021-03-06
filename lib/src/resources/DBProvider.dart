import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class DbProvider {
  Database db;

  init() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    final path = join(docsDirectory.path, "jami15.db");
    // await deleteDatabase(path);
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) async {
        await newDb.execute(
          """
            CREATE TABLE voters
            (
              id INTEGER PRIMARY KEY,
              hash VARCHAR(255)
            );
             CREATE TABLE results
            (
              id INTEGER PRIMARY KEY,
              result VARCHAR(255)
            );
          """,
        );
        await newDb.execute(
          """
             CREATE TABLE results
            (
              id INTEGER PRIMARY KEY,
              result VARCHAR(255)
            );
          """,
        );
      },
    );
  }

  close() async {
    await db.close();
  }

  Future<void> add(String hash) async {
    final result = await db.query(
      "voters",
      columns: ["hash"],
      where: "hash = ?",
      whereArgs: [hash],
    );

    if (result.length == 0) {
      await db.insert(
        "voters",
        {"hash": hash},
      );
    }
  }

  Future<void> addRes(String res) async {
    await db.insert(
      "results",
      {"result": res},
    );
  }

  Future<List> fetchResult() async {
    final result = await db.query(
      "results",
      columns: ["result"],
    );

    return result;
  }

  Future<List> fetchHash() async {
    final result = await db.query(
      "voters",
      columns: ["hash"],
    );

    return result;
  }
}

final dbProvider = DbProvider();
