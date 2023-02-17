import 'package:flutter/material.dart';
import '../../database_helper/database_helper.dart';
import '../../models/notebook.dart';
import '../../pages/notebook_page.dart';
import '../../pages/registration_page.dart';


class NotebookProvider extends ChangeNotifier {
  List<Notebook>? _notebook;
  DatabaseHelper? _db;
  int _bottomNavIndex = 0;

  List<Notebook> get notebook => _notebook!;

  DatabaseHelper get db => _db!;

  set db(DatabaseHelper value) {
    _db = value;
  }

  int get bottomNavIndex => _bottomNavIndex;

  set bottomNavIndex(int value) {
    _bottomNavIndex = value;
  }

  set notebook(List<Notebook> value) {
    _notebook = value;
  }

  void resetNotebook() {
    notebook = [];
  }

  void fetchNoteListCtl() async {
    db = DatabaseHelper();
    try {
      List<Notebook> mNotebook = await _db!.fetchNoteList();
      if (mNotebook.isNotEmpty) {
        _notebook = mNotebook;
      }
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
  }

  Future<void> bottomNavRouterCtl(BuildContext context, index) async {
    if (index == 1) {
      bool? isAdded = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NoteBookPage(),
        ),
      );
      if (isAdded == true) {
        resetNotebook();
        fetchNoteListCtl();
      }
      else if (index == 2) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const RegistrationPage(),
          ),
        );
      }
      notifyListeners();
    }

    Future<void> deleteListTileCtl(index) async {
      int id = _notebook![index].id!;
      int isDeleted = await _db!.deleteNote(id);
      if (isDeleted > 0) {
        resetNotebook();
        fetchNoteListCtl();
      }
      notifyListeners();
    }
  }
}
