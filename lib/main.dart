import 'package:flutter/material.dart';
import 'package:note_book_app/controllers/providers/authentication_provider.dart';
import 'package:note_book_app/controllers/providers/notebook_provider.dart';
import 'package:note_book_app/pages/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (context) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider<NotebookProvider>(
          create: (context) => NotebookProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.yellow[500]),
      home: SplashPage(),
    );
  }
}
