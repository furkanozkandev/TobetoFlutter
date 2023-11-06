import 'package:flutter/material.dart';
import 'questions.dart';
import 'answers.dart';
import 'question_model.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Quiz Uygulaması'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              questions[currentQuestionIndex].question,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ...questions[currentQuestionIndex]
                .options
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              String option = entry.value;
              return ElevatedButton(
                onPressed: () {
                  int correctAnswerIndex =
                      questions[currentQuestionIndex].correctAnswerIndex;
                  if (index == correctAnswerIndex) {
                    // Cevap doğru ise bir sonraki soruya geç
                    if (currentQuestionIndex < questions.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                      });
                    } else {
                      // Tüm soruları cevapladıysak, bir mesaj görüntüle
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Tebrikler! Quiz tamamlandı.'),
                            content: Text('Tüm soruları doğru cevapladınız.'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Kapat'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: Text(option),
              );
            }),
          ],
        ),
      ),
    );
  }
}
