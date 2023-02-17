import 'package:flutter/material.dart';
import '../../database_helper/database_helper.dart';
import '../../models/notebook.dart';
import '../../pages/notebook_page.dart';
import '../../pages/registration_page.dart';

class NotebookProvider extends ChangeNotifier {
  List<Notebook> _notebook = [];
  DatabaseHelper? _db;
  int bottomNavIndex = 0;
  String currentDate = DateTime.now().toString().substring(0, 11);
  TextEditingController userDetailsTextCtl = TextEditingController();

  TextEditingController userTitleTextCtl = TextEditingController();

  List<Notebook> get notebook => _notebook;

  DatabaseHelper get db => _db!;

  set db(DatabaseHelper value) {
    _db = value;
  }

  set notebook(List<Notebook> value) {
    _notebook = value;
  }

  void resetNotebook() {
    notebook = [];
    notifyListeners();
  }

  void datePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      currentDate = value.toString().substring(0, 11);
      notifyListeners();
    });
  }

  void noteAdder(BuildContext context) async {
    try {
      Notebook mNotebook = Notebook(
          title: userTitleTextCtl.text,
          description: userDetailsTextCtl.text,
          timeadded: currentDate);
      int isAdded = await db.insertNote(mNotebook);

      if (isAdded > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Note Added Succesfully"),
          ),
        );
        Navigator.pop(context, true);
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
        notebook = mNotebook;
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
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegistrationPage(),
          ),
        );
      }
      notifyListeners();
    }

  }
  Future<void> deleteListTileCtl(index) async {
    int id = notebook[index].id!;
    int isDeleted = await db.deleteNote(id);
    if (isDeleted > 0) {
      resetNotebook();
      fetchNoteListCtl();
    }
    notifyListeners();
  }
}
