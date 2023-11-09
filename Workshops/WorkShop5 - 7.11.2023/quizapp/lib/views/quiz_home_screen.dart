import 'package:flutter/material.dart';


class QuizHomeScreen extends StatefulWidget {
  const QuizHomeScreen({super.key});

  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
  String textTitle = "Flutter Quiz";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("lib/assets/images/quiz.png", width: 410),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              textTitle,
              style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/toQuestions');
              },
              child: const Text("Quiz'i Başlat"))
        ],
      )),
    );
  }
}
