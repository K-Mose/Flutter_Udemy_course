import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat("y-MM-dd");

class NewExpense extends StatefulWidget {
  const NewExpense(this._addExpense, {super.key});

  final void Function(Expense expense) _addExpense;

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
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    // async-await : await 이후 코드는 동기식으로 실행 됨. then으로 하면 then 내부에서만 Future로 받은 데이터 사용, 이후 코드는 비동기식으로 진행
    setState(() {
      print(selectedDate);
      _selectedDate = selectedDate;
    });
  }

  void _submitExpenseDate() {
    // validate data
    final amount = double.tryParse(_amountController.text);

    if (_titleController.text.trim().isEmpty 
        || amount == null || amount <= 0 || _selectedDate == null) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text("Invalid Input"),
        content: const Text("Please make sure a valid title, amount, date and category was entered."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close")
          ),
        ],
      ),);
      return;
    }
    widget._addExpense(
        Expense(
          title: _titleController.text,
          amount: amount,
          date: _selectedDate!,
          category: _selectedCategory!
      )
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose(); // 하지 않는다면 메모리 누수 발생
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 바닥과의 offset
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox( //꽉찬 모달창으로 띄우기 위해
      height: double.infinity,
      // 키보드가 올라왔을 때 하위 항목들을 볼 수 있게 스크롤링 추가
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16), // 키보드가 올라오는 위치만큼 bottom padding 추가
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
                        Text(_selectedDate != null ? formatter.format(_selectedDate!) : "Selected Date"),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month)
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map((c) => DropdownMenuItem(
                        value: c, // onChange의 타입으로 자동 매핑
                        child: Text(c.name.toUpperCase())
                    )).toList(),
                    onChanged: (category) {
                      setState(() {
                        _selectedCategory = category ?? _selectedCategory;
                      });
                    }),
                  const Spacer(),
                  TextButton(onPressed: () {
                    Navigator.pop(context); // 현재 modal context를 pop시킴
                  }, child: const Text("Cancel")),
                  ElevatedButton(
                    onPressed: _submitExpenseDate,
                    child: const Text("Save Expense")
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}