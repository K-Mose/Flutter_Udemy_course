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
  1. onChange 메소드 업데이트[
  String _title = "";
  void _saveTitleInput(String inputValue) {
    _title = inputValue;
  }
  2. TextEditingController 이용
    - controller는 보이지 않는 상태에서도 메모리를 소모하므로
      생성 후 더이상 필오하지 않다면 닫아줘야 함 > dispose 사용
   */
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
  }

  @override
  void dispose() {
    _titleController.dispose(); // 하지 않는다면 메모리 누수 발생
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            // onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text("Title")
            ),
          ),
          Row(
            children: [
              // 공간 확보를 위해 Expanded
              // Expanded가 2개이므로 1:1 비율로 생성됨
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Amount")
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Selected Date"),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month)
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                },
                child: const Text("Enter")
              ),
              TextButton(onPressed: () {
                Navigator.pop(context); // 현재 modal context를 pop시킴
              }, child: const Text("Cancel"))
            ],
          )
        ],
      ),
    );
  }
}