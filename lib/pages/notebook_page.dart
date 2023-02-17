import 'package:flutter/material.dart';
import 'package:note_book_app/controllers/providers/notebook_provider.dart';
import 'package:provider/provider.dart';

class NoteBookPage extends StatefulWidget {
  const NoteBookPage({Key? key}) : super(key: key);

  @override
  State<NoteBookPage> createState() => _NoteBookPageState();
}

class _NoteBookPageState extends State<NoteBookPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotebookProvider notebookProvider = Provider.of(context, listen: false);
    notebookProvider.fetchNoteListCtl();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotebookProvider>(builder: (_, provider, ___) {
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
                controller: provider.userTitleTextCtl,
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
                controller: provider.userDetailsTextCtl,
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
                title: Text(provider.currentDate),
                trailing: InkWell(
                    onTap: () {
                      provider.datePicker(context);
                    },
                    child: Icon(Icons.calendar_month)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (provider.userTitleTextCtl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please Enter Title"),
                    ),
                  );
                } else if (provider.userDetailsTextCtl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please Enter Details"),
                    ),
                  );
                } else {
                  provider.noteAdder(context);
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
      );
    });
  }
}
