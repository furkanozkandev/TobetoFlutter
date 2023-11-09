import 'package:flutter/material.dart';
import 'package:quizapp/data/questions.dart';
import 'package:quizapp/views/result_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentPage = 1;
  int currentQuestionIndex = 0;
  int numberOfCorrectAnswer = 0;
  List<int> wrongAnsweredQuestion = [];

  void updateQuestionAndPage() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        currentPage++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultScreen(
                    correctAnswers: numberOfCorrectAnswer,
                    wrongAnswer: wrongAnsweredQuestion,
                  )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$currentPage. Soru',
            style: const TextStyle(
                color: Colors.brown,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, //
              children: [
                Text(
                  questions[currentQuestionIndex].question,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height: 32), //
                ...questions[currentQuestionIndex].answers.map((answer) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (answer ==
                              questions[currentQuestionIndex].correctAnswer) {
                            numberOfCorrectAnswer += 1;
                          } else {
                            wrongAnsweredQuestion.add(currentQuestionIndex);
                          }
                        });
                        updateQuestionAndPage();
                      },
                      child: Text(
                        answer,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ana Sayfa'),
          )
        ],
      )),
    );
  }
}
