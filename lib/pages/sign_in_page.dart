import 'package:flutter/material.dart';
import 'package:note_book_app/database_helper/database_helper.dart';
import 'package:note_book_app/pages/home_page.dart';
import 'package:note_book_app/pages/registration_page.dart';
import 'package:note_book_app/util/shared_pref.dart';

import '../models/user_info.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  DatabaseHelper? db;
  TextEditingController? userNameTextCtl;
  TextEditingController? passwordTextCtl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameTextCtl = TextEditingController();
    passwordTextCtl = TextEditingController();
    db = DatabaseHelper();


  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Sign In",
              style: TextStyle(fontSize: 40),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: TextFormField(
                validator: (value) {
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
                  hintStyle: const TextStyle(color: Colors.black45),
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  focusedBorder: const OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              child: TextFormField(
                validator: (value) {
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
                  hintStyle: const TextStyle(color: Colors.black45),
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  focusedBorder: const OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                bool isValid = await db!
                    .isValidUser(userNameTextCtl!.text, passwordTextCtl!.text);
                if (isValid) {
                  List<UserInfo> userData =
                      await db!.fetchUserInfoList(userNameTextCtl!.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Sign-In Successful"),
                    ),

                  );
                  PrefManagement.setUserId(userData[0].id!);
                  PrefManagement.setLoggedIn(true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(userData[0]),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "User Not Found Please check your credentials and try again"),
                    ),
                  );
                }
              },
              child: Text("Sign in"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()));
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
