import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  // StatelessWidget의 필드들은 상수여야함
  final String questionText;

  // StatelessWidget이 input data를 Constructor를 통해 받음
  // StatelessWidget은 input data가 constructor를 통해 변할 때만 re-render 함
  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20, top: 40),
        child: Text(
          questionText,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ));
  }
}
