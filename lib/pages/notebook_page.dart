import 'package:flutter/material.dart';
import 'package:note_book_app/database_helper/database_helper.dart';
import 'package:note_book_app/models/notebook.dart';

class NoteBookPage extends StatefulWidget {
  const NoteBookPage({Key? key}) : super(key: key);

  @override
  State<NoteBookPage> createState() => _NoteBookPageState();
}

class _NoteBookPageState extends State<NoteBookPage> {
  String? currentDate;
  TextEditingController? userDetailsTextCtl;
  TextEditingController? userTitleTextCtl;
  DatabaseHelper? _db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDate = DateTime.now().toString().substring(0, 11);
    userDetailsTextCtl = TextEditingController();
    userTitleTextCtl = TextEditingController();
    _db = DatabaseHelper();
  }

  void noteAdder() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "New Note",
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: TextField(
              controller: userTitleTextCtl,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title),
                prefixIconColor: Colors.yellow[500],
                enabledBorder: InputBorder.none,
                hintText: "Title",
                fillColor: Colors.grey.shade500,
                filled: true,
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: TextField(
              controller: userDetailsTextCtl,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.details),
                prefixIconColor: Colors.yellow[500],
                hintText: "Details",
                fillColor: Colors.grey.shade500,
                filled: true,
                enabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: ListTile(
              tileColor: Colors.grey.shade500,
              title: Text(currentDate!),
              trailing: InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050))
                        .then((value) => setState(() {
                              currentDate = value.toString().substring(0, 11);
                            }));
                  },
                  child: Icon(Icons.calendar_month)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (userTitleTextCtl!.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please Enter Title"),
                  ),
                );
              } else if (userDetailsTextCtl!.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please Enter Details"),
                  ),
                );
              } else {
                noteAdder();
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
