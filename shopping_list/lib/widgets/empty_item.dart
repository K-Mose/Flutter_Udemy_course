import 'package:flutter/cupertino.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "You get Nothing. \n\n Pleas, Add Some Item.",
        textAlign: TextAlign.center,
      ),
    );
  }
}
