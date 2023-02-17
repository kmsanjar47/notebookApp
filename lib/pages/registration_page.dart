import 'package:flutter/material.dart';
import 'package:note_book_app/controllers/providers/authentication_provider.dart';
import 'package:note_book_app/database_helper/database_helper.dart';
import 'package:note_book_app/models/user_info.dart';
import 'package:note_book_app/pages/sign_in_page.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController? userNameTextCtl;
  TextEditingController? emailTextCtl;
  TextEditingController? passwordTextCtl;
  GlobalKey<FormState>? fromKey;
  String? dateCreated;
  DatabaseHelper? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameTextCtl = TextEditingController();
    emailTextCtl = TextEditingController();
    passwordTextCtl = TextEditingController();
    fromKey = GlobalKey<FormState>();
    dateCreated = DateTime.now().toString().substring(0, 11);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: fromKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: TextStyle(fontSize: 40),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: TextFormField(
                validator: (String? value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return "Please Enter Valid Username";
                  }
                },
                controller: userNameTextCtl,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "User name",
                  hintStyle: TextStyle(color: Colors.black45),
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: TextFormField(
                validator: (String? value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return "Please Enter Valid Email";
                  }
                },
                controller: emailTextCtl,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.black45),
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: TextFormField(
                validator: (String? value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return "Please Enter Valid Password";
                  }
                },
                controller: passwordTextCtl,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black45),
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (fromKey!.currentState!.validate()) {
                  bool isExist = await db!.isExist(
                      userNameTextCtl!.text, emailTextCtl!.text);
                  if (isExist == false) {
                    int isAdded = await db!.insertUserInfo(
                      UserInfo(
                          username: userNameTextCtl!.text,
                          email: emailTextCtl!.text,
                          password: passwordTextCtl!.text,
                          datecreated:
                              DateTime.now().toString().substring(0, 11)),
                    );
                    if (isAdded > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Registration Successful"),
                        ),
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()));
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Registration Unsuccessful. Please try again."),
                        ),
                      );
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Username or email already exist!! Please Re-enter"),
                      ),
                    );
                  }
                }
              },
              child: Text("Register"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: Text(
                    "Sign in",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
