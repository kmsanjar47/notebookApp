import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:note_book_app/controllers/providers/notebook_provider.dart';
import 'package:note_book_app/models/user_info.dart';
import 'package:note_book_app/pages/expanded_note_page.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';

class HomePage extends StatefulWidget {
  final UserInfo? userInfoData;

  const HomePage(this.userInfoData, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotebookProvider notebookProvider = Provider.of<NotebookProvider>(context,listen: false);
    notebookProvider.fetchNoteListCtl();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotebookProvider>(
      builder: (_,provider,___) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
            title: const Text(
              "NoteBook",
              style: TextStyle(color: Colors.black),
            ),
          ),
          drawer: Drawer(
            backgroundColor: Colors.yellow[500],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            animationDuration: const Duration(milliseconds: 150),
            height: 60,
            backgroundColor: Colors.transparent,
            color: Colors.yellow.shade500,
            items: const <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.add, size: 30),
              Icon(Icons.person, size: 30),
            ],
            onTap: (index) {
              //Handle button tap
              provider.bottomNavRouterCtl(context, index);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "${Util.greetings()}, ${widget.userInfoData!.username}!!",
                  style: const TextStyle(fontSize: 35),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.black),
                      labelText: 'Search...',
                      filled: true,
                      fillColor: Colors.yellowAccent.shade400,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                provider.notebook != []
                    ? Expanded(
                        child: ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ExpandedNote(provider.notebook[index].id),),);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8, right: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2,
                                            offset: Offset(1, 1),
                                            spreadRadius: 1),
                                      ],
                                      color: Colors.yellow[400],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                provider.notebook[index].title!,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                provider.notebook[index].description!,
                                                style:
                                                    const TextStyle(fontSize: 16),
                                              ),
                                              Text(provider.notebook[index].timeadded!),
                                            ],
                                          ),
                                          PopupMenuButton<int>(
                                            position: PopupMenuPosition.under,
                                            itemBuilder: (BuildContext context) {
                                              return <PopupMenuEntry<int>>[
                                                PopupMenuItem(
                                                  child: Row(
                                                    children: const [
                                                      Icon(Icons.edit),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("Edit"),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                    onTap: () {
                                                      provider.deleteListTileCtl(index);
                                                    },
                                                    child: Row(
                                                      children: const [
                                                        Icon(Icons.delete),
                                                        Text("Delete")
                                                      ],
                                                    ),),
                                              ];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: provider.notebook.length),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      }
    );
  }
}
