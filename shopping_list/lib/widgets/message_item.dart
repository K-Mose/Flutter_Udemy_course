import 'package:flutter/cupertino.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
  }
}
