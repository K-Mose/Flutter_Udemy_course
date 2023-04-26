import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  /*
  const vs final
  cosnt - compiletime constant value
  fianl - runtime constant value
  */
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}
