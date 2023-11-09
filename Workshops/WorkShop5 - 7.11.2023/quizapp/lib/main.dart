import 'package:flutter/material.dart';
import 'package:quizapp/views/questions_screen.dart';
import 'package:quizapp/views/quiz_home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.redAccent,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ))),
      home: const QuizHomeScreen(),
      routes: {
        '/toQuestions': (context) => const QuestionScreen(),
        '/toHome': (context) => const QuizHomeScreen()
      },
    ),
  );
}
