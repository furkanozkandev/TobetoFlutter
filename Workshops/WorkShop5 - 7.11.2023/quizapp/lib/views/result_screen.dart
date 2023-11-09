import 'package:flutter/material.dart';
import 'package:quizapp/data/questions.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final List<int> wrongAnswer;

  const ResultScreen({required this.correctAnswers, required this.wrongAnswer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Doğru Cevap: $correctAnswers/10',
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/toHome');
            },
          ),
        ),
        backgroundColor: Colors.lightGreen,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Yanlış Cevaplar',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: wrongAnswer.length,
                itemBuilder: (context, index) {
                  final wrongQuestionIndex = wrongAnswer[index];
                  final question = questions[wrongQuestionIndex];
                  return ListTile(
                    title: Text(question.question),
                    subtitle: Text('${question.correctAnswer}'),
                  );
                },
              ),
            )
          ],
        ));
  }
}
