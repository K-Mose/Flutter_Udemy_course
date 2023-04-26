import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz(
      {@required this.questions,
      @required this.answerQuestion,
      @required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Statefull 안에 Stateless Widget을 넣음
        Question(questions[questionIndex]['questionText'] as String),
        // ... -> spread operator used for inserting multiple elements in a collection
        ...(questions[questionIndex]['answers'] as List).map((answer) {
          return Answer(
              (() => answerQuestion(answer['score'])), answer['text']);
        }).toList()
      ],
    );
  }
}
