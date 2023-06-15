import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/utils/constants.dart';

class NewItem extends StatefulWidget {

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  // globalKey는 보통 form에서만 사용
  // FormState 타입의 키를 생성
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredQuantity = 0;
  var _selectedCategory = categories[Categories.vegetables]; // 초기값설정
  var _isSending = false;

  final tc = TextEditingController();
  var controller = TextEditingController();
  void _saveItem() async {
    setState(() {
      _isSending = true;
    });
    // formState에 속해있는 모든 validation 실행, pass: true, fail: false
    if(_formKey.currentState!.validate()) {
      // 상태에 formField 이터를 저장
      _formKey.currentState!.save();
      // httsp(url without protocol, path,
      final url = Uri.https(BASE_URL, 'shopping-list.json' );
      print("request post, $url");
      // Http request
      final response = await http.post(
        url,
        headers: {
          "Content-Type": 'application/json'
        },
          // convert data to json format
        body: json.encode({
          "name": _enteredName,
          "quantity": _enteredQuantity,
          "category": _selectedCategory!.name
        })
      );
      // Future type으로 받을 시
      /*.then((response) {
        print(response);
        print(response.body);
        // work with response
        if (response.statusCode >= 200 && response.statusCode < 300) {
          Navigator.of(context).pop();
        }
      });*/
      // 현재 컨텍스트가 위젯트리에 위치하고 있는지
      if (!context.mounted) {
        return;
      }
      final Map<String,dynamic> resData = json.decode(response.body);
      Navigator.of(context).pop(
        GroceryItem(
          id: resData["name"],
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory!));
      // meal app 에서 사용했던 pop으로 데이터 넘기기
      /*Navigator.of(context).pop(GroceryItem(
          id: DateTime.now().toString(),
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory!
      ));*/
    }
  }

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
          key: _formKey, // key를 이용하여 Form에 접근
          child: Column(
            children: [
              // user input
              TextFormField( // instead of TextField(), Form feature
                maxLength: 50,
                controller: tc,
                decoration: const InputDecoration(
                  label: Text("Name")
                ),
                // flutter에서 내부적으로 validate 처리
                validator: (value) {
                  // return validation message
                  // return null -> success / Stirng -> validated
                  if (value == null || value.isEmpty
                      || value.trim().length <= 1 || value.trim().length > 50) {
                    return "Must be between 1 and 50 characters.";
                  }
                  return null;
                },
                // FormState에서 save가 호출 됐을 때
                onSaved: (value) {
                  _enteredName = value!;
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
                      keyboardType: TextInputType.number,
                      initialValue: "1",
                      validator: (value) {
                        if (value == null
                            || value.isEmpty
                            || int.tryParse(value) == null
                            || int.tryParse(value)! <= 0) {
                          return "Must be a valid, positive number.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                    child: DropdownButtonFormField(
                      // dropdown에서 내부적으로 관리하는 값
                      value: _selectedCategory,
                      items: [
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
                      _selectedCategory = value;
                      print(_selectedCategory!.name);
                    }),
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending ? null : () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text("Reset")
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: _isSending ? null :  _saveItem,
                    child: _isSending ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator()
                    ) :  const Text("Add Item")
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