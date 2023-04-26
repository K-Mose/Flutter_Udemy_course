import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/question.dart';
import 'package:flutter_complete_guide/quiz.dart';
import 'package:flutter_complete_guide/result.dart';

// void main() {
//   runApp(MyApp());
// }

// 람다식
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': "What's your favorit color?",
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 7},
        {'text': 'Green', 'score': 5},
        {'text': 'Yellow', 'score': 3},
        {'text': 'White', 'score': 1},
      ]
    },
    {
      'questionText': "What's your favorit fruit?",
      'answers': [
        {'text': 'Orange', 'score': 10},
        {'text': 'StrawBerry', 'score': 7},
        {'text': 'Banana', 'score': 5},
        {'text': 'Apple', 'score': 3},
        {'text': 'Peach', 'score': 1},
      ]
    },
    {
      'questionText': "What's your favorit workout?",
      'answers': [
        {'text': 'Clean', 'score': 10},
        {'text': 'Snatch', 'score': 7},
        {'text': 'Push-up', 'score': 5},
        {'text': 'Pull-up', 'score': 3},
        {'text': 'Squat', 'score': 1},
      ]
    },
    {
      'questionText': "What's your favorit animal?",
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Snake', 'score': 7},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 3},
        {'text': 'Dog', 'score': 1},
      ]
    }
  ];

  // State가 MyApp에 속해있다 나타냄
  var _questionIndex = 0;
  var _score = 0;
  void _answerQuestion(int score) {
    // 업데이트 시켜야 하는 상태를 setState 함수 안에 넣음
    _score += score;
    setState(() {
      if (_questionIndex < _questions.length) {
        _questionIndex += 1;
      }
    });
    print('Answer choosen!');
  }

  void _restQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("title text")),
        body: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
              )
            : Result(_score, _restQuiz),
      ),
    );
  }
}
