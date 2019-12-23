import 'package:flutter/material.dart';

import './result.dart';
import './quiz.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = [
    {
      'questionText': 'What\'s your favourite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 8},
        {'text': 'Green', 'score': 6},
        {'text': 'White', 'score': 5}
      ],
    },
    {
      'questionText': 'What\'s your favourite animal',
      'answers': [
        {'text': 'Rabbit', 'score': 100},
        {'text': 'snake', 'score': 200},
        {'text': 'dog', 'score': 400},
        {'text': 'cat', 'score': 600}
      ]
    },
  ];

  var _totalScore = 0;
  var _questionIndex = 0;

  void _resetQuiz(){
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }
  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    print('this is clicked');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            children: <Widget>[
              Text('Question Answer'),
            ],
          ),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions)
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
