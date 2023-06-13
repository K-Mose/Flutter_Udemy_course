import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Quantity")
                      ),
                      initialValue: "1",
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                    child: DropdownButtonFormField(items: [
                      for(final category in categories.entries)
                        DropdownMenuItem(
                          // 카테고리 객체 자체를 value로 할당
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              ),
                              const SizedBox(width: 6,),
                              Text(category.value.name)
                            ],
                          )
                        )
                    ],
                    onChanged: (value) {
                      print(value);
                    }),
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Reset")
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Add Item")
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}