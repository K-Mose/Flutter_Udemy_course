import 'package:flutter/material.dart';

class NewItem extends StatefulWidget {

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        // Form - Combination of input fields
        child: Form(
          child: Column(
            children: [
              // user input
              TextFormField( // instead of TextField(), Form feature
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Name")
                ),
                // flutter에서 내부적으로 validate 처리
                validator: (value) {
                  // return validation message
                  return 'Demo validation';
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}