import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  /*
  // TextField 입력방법
  1. onChange 메소드 업데이트
   */
  String _title = "";
  void _saveTitleInput(String inputValue) {
    _title = inputValue;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: _saveTitleInput,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text("Title")
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {print(_title);},
                child: const Text("Enter")
              )
            ],
          )
        ],
      ),
    );
  }
}