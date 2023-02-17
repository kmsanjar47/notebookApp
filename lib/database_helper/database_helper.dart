import 'dart:io';
import 'package:note_book_app/constants/constants.dart';
import 'package:note_book_app/models/notebook.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_info.dart';

class DatabaseHelper {
  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'notebookDB.SQLITE');
    return openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE ${Constants.noteDbName} (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT,timeadded TEXT )');
      db.execute(
          'CREATE TABLE ${Constants.userInfoDbName} (id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT,email TEXT,password TEXT, date_created TEXT)');
    });
  }

  Future<int> insertNote(Notebook notebook) async {
    Database db = await initDatabase();
    return db.insert(Constants.noteDbName, notebook.toMap());
  }

  Future<int> insertUserInfo(UserInfo userInfo) async {
    Database db = await initDatabase();
    return db.insert(Constants.userInfoDbName, userInfo.toMap());
  }

  Future<List<Notebook>> fetchNoteList() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> notebookMapList =
        await db.query(Constants.noteDbName);
    List<Notebook> notebookList = List.generate(
      notebookMapList.length,
      (index) {
        return Notebook(
            id: notebookMapList[index]["id"],
            title: notebookMapList[index]["title"],
            description: notebookMapList[index]["description"],
            timeadded: notebookMapList[index]["timeadded"]);
      },
    );
    return notebookList;
  }

  Future<List<UserInfo>> fetchUserInfoList(String? username) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userInfoMapList =
        await db.query(Constants.userInfoDbName,where: "username = ?",whereArgs: [username]);
    List<UserInfo> userInfoList = List.generate(
      userInfoMapList.length,
      (index) {
        return UserInfo(
          id: userInfoMapList[index]["id"],
          username: userInfoMapList[index]["username"],
          email: userInfoMapList[index]["email"],
          password: userInfoMapList[index]["password"],
          datecreated: userInfoMapList[index]["date_created"],
        );
      },
    );
    return userInfoList;
  }

  Future<int> deleteNote(int id) async {
    Database db = await initDatabase();
    return db.delete(Constants.noteDbName, where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteNoteTable(String tableName) async {
    Database db = await initDatabase();
    return db.delete(tableName);
  }

  Future<List<Notebook>> getSpecificNote(int? id) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> noteMapList =
        await db.query(Constants.noteDbName, where: "id = ?", whereArgs: [id]);

    return List.generate(
        noteMapList.length,
        (index) => Notebook(
            title: noteMapList[index]["title"],
            description: noteMapList[index]["description"],
            timeadded: noteMapList[index]["timeadded"]));
  }

  Future<bool> isExist(String? userName, String? email) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userExist = await db.rawQuery(
        "SELECT * FROM ${Constants.userInfoDbName} WHERE username='$userName'");
    List<Map<String, dynamic>> emailExist = await db.rawQuery(
        "SELECT * FROM ${Constants.userInfoDbName} WHERE email='$email'");
    if (userExist.isNotEmpty && emailExist.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isValidUser(String? userName, String? password) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userExist = await db.rawQuery(
        "SELECT * FROM ${Constants.userInfoDbName} WHERE username='$userName' AND password='$password'");
    if (userExist.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<UserInfo>> getSpecificUser(int? id) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userMapList = await db
        .query(Constants.userInfoDbName, where: "id = ?", whereArgs: [id]);

    return List.generate(
        userMapList.length,
        (index) => UserInfo(
            username: userMapList[index]["username"],
            email: userMapList[index]["email"],
            password: userMapList[index]["password"],
            datecreated: userMapList[index]["date_created"]));
  }
}
