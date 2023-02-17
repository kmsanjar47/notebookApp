import 'package:flutter/material.dart';
import '../../database_helper/database_helper.dart';
import '../../models/notebook.dart';
import '../../pages/notebook_page.dart';
import '../../pages/registration_page.dart';


class NotebookProvider extends ChangeNotifier {
  List<Notebook>? _notebook;
  DatabaseHelper? _db;
  int _bottomNavIndex = 0;
  String _currentDate = DateTime.now().toString().substring(0, 11);
  TextEditingController _userDetailsTextCtl = TextEditingController();

  String get currentDate => _currentDate!;

  set currentDate(String value) {
    _currentDate = value;
  }

  TextEditingController _userTitleTextCtl = TextEditingController();


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
  TextEditingController get userDetailsTextCtl => _userDetailsTextCtl;

  set userDetailsTextCtl(TextEditingController value) {
    _userDetailsTextCtl = value;
  }

  TextEditingController get userTitleTextCtl => _userTitleTextCtl;

  set userTitleTextCtl(TextEditingController value) {
    _userTitleTextCtl = value;
  }

  void resetNotebook() {
    notebook = [];
    notifyListeners();
  }
  void noteAdder(BuildContext context) async {
    try {
      Notebook mNotebook = Notebook(
          title: userTitleTextCtl!.text,
          description: userDetailsTextCtl!.text,
          timeadded: currentDate);
      int isAdded = await _db!.insertNote(mNotebook);

      if (isAdded > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Note Added Succesfully"),
          ),
        );
        Navigator.pop(context,true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error!! Can't add note right now"),
        ));
      }
    } catch (error) {
      print(error.toString());
    }
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
