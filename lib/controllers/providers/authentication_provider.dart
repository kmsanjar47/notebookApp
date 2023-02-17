import 'package:flutter/cupertino.dart';

import '../../database_helper/database_helper.dart';

class AuthenticationProvider extends ChangeNotifier{
  TextEditingController userNameTextCtl = TextEditingController();
  TextEditingController emailTextCtl= TextEditingController();
  TextEditingController passwordTextCtl= TextEditingController();
  GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  String? dateCreated;
  DatabaseHelper? _db;

  DatabaseHelper get db => _db!;

  set db(DatabaseHelper value) {
    _db = value;
  }

}