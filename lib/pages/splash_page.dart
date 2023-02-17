import 'dart:async';
import 'package:flutter/material.dart';
import 'package:note_book_app/database_helper/database_helper.dart';
import 'package:note_book_app/models/user_info.dart';
import 'package:note_book_app/pages/home_page.dart';
import 'package:note_book_app/pages/sign_in_page.dart';
import '../util/shared_pref.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  DatabaseHelper? db;

  @override
  void initState() {
    super.initState();
    initSharePref();
    db = DatabaseHelper();
  }

  initSharePref() async {
    await PrefManagement.init();
    redirectToMyPage();
  }

  void redirectToMyPage() {
    Timer(const Duration(seconds: 3), () async {
      if (PrefManagement.getLoggedIn() != null &&
          PrefManagement.getLoggedIn() == true) {
        int? userId = PrefManagement.getUserId();
        List<UserInfo> userData = await db!.getSpecificUser(userId!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(userData[0]),
          ),
        );
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignInPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        color: Colors.yellow[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Note Book',
              style: TextStyle(
                fontSize: 38,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 3,
              width: 200,
              child: LinearProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
