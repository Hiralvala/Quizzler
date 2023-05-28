import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(quizzler());
}

class quizzler extends StatelessWidget {
  const quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoretTest = [];

  void checkAnswer(bool userpickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      //if we at the last question it is show alert message otherwise add icon in scoretest

      if (quizBrain.isfinished() == true) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('Finished!'),
                  content: Text('You\'ve reached the end of the quiz'),
                  actions: [
                    TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () => Navigator.pop(context, 'ok'),
                        child: Text(
                          'Finish',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ));

        quizBrain.reset();
        //reset the question number

        //empty scoretest
        scoretTest = [];
      }
      //if we not reached at the end,then ...
      else {
        if (userpickedAnswer == correctAnswer) {
          scoretTest.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoretTest.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
      }
      quizBrain.nextQuestion();
    });
  }
  // List<String> questions = [
  //   'You can leed a cow down stairs but not up stairs',
  //   'Approximately one quarter of human bones are in the feet',
  //   'A slug\'s blood is green'
  // ];
  // List<bool> answer = [false, true, true];
  // Question q1 = Question(q: 'You can leed a cow down stairs but not up stairs', a: false);

  // int questionNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                checkAnswer(true);
              },
              child: Text(
                'True',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                'False',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoretTest,
        ),
      ],
    );
  }
}
