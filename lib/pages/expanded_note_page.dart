import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_book_app/controllers/providers/notebook_provider.dart';
import 'package:provider/provider.dart';

class ExpandedNote extends StatefulWidget {
  final int? userId;

  const ExpandedNote(this.userId, {Key? key}) : super(key: key);

  @override
  State<ExpandedNote> createState() => _ExpandedNoteState();
}

class _ExpandedNoteState extends State<ExpandedNote> {
  late int? id = widget.userId;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotebookProvider notebookProvider = Provider.of(context,listen: false);
    notebookProvider.fetchNoteListCtl();
    notebookProvider.getNoteList(id);
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<NotebookProvider>(
      builder: (_,provider,___) {
        return Scaffold(
          backgroundColor: Colors.yellow[400],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: provider.noteList != null
              ? Column(
                  children: [
                    Center(
                      child: Text(
                        provider.noteList![0].title!,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10),),
                          border: Border.all(color: Colors.white,width: 2),
                          color: Colors.yellow[200],
                        ),
                        child: Text(
                          provider.noteList![0].description!,
                          style: TextStyle(fontSize: 20),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      provider.noteList![0].timeadded!,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              : Container(),
        );
      }
    );
  }
}
