import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
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
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int i = Random().nextInt(12) + 1;
  int score = 0, a = 1;
  List<String> QuestionBank = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.',
    'Some cats are actually allergic to humans',
    'Buzz Aldrin\'s mother\'s maiden name was \"Moon\".',
    'It is illegal to pee in the Ocean in Portugal.',
    'No piece of square dry paper can be folded in half more than 7 times.',
    'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
    'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
    'The total surface area of two human lungs is approximately 70 square metres.',
    'Google was originally called \"Backrub\".',
    'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
    'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
  ];
  List<String> Questions = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.',
    'Some cats are actually allergic to humans',
    'Buzz Aldrin\'s mother\'s maiden name was \"Moon\".',
    'It is illegal to pee in the Ocean in Portugal.',
    'No piece of square dry paper can be folded in half more than 7 times.',
    'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
    'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
    'The total surface area of two human lungs is approximately 70 square metres.',
    'Google was originally called \"Backrub\".',
    'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
    'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
  ];
  List<bool> SOLUTIONS = [
    false,
    true,
    true,
    true,
    true,
    true,
    false,
    true,
    false,
    true,
    true,
    true,
    true,
  ];
  List<bool> Answers = [
    false,
    true,
    true,
    true,
    true,
    true,
    false,
    true,
    false,
    true,
    true,
    true,
    true,
  ];
  void check(bool sol) {
    if (sol == Answers[i]) {
      if (a < 7) {
        setState(() {
          score++;
          ScoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          if (a != 6) {
            Questions.remove(
              Questions[i],
            );
            Answers.remove(
              Answers[i],
            );
            i = Random().nextInt(Questions.length - 1) + 1;
          }
        });
      }
    } else {
      if (a < 7) {
        setState(() {
          ScoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
          if (a != 6) {
            Questions.remove(
              Questions[i],
            );
            Answers.remove(
              Answers[i],
            );
            i = Random().nextInt(Questions.length - 1) + 1;
          }
        });
      }
    }
    if (a == 6) {
      setState(() {
        Alert(
          context: context,
          title: "Your Score",
          desc: "$score/6",
          style: AlertStyle(
            descStyle: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
          ),
          buttons: [
            DialogButton(
              child: Text(
                "RESET",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  ScoreKeeper = [];
                  Answers.addAll(SOLUTIONS);
                  Questions.addAll(QuestionBank);
                  a = 1;
                  score = 0;
                  i = Random().nextInt(Questions.length - 1) + 1;
                });
                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      });
    }
  }

  List<Widget> ScoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                Questions[i],
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
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                check(true);
                a++;
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                check(false);
                a++;
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ScoreKeeper,
        ),
      ],
    );
  }
}
