import 'package:flutter/material.dart';
// import 'package:quiz_app/intro_page.dart';

import 'intro_page.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        hintColor: Colors.deepPurpleAccent,
        backgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
      home: IntroPage(),
    );
  }
}
