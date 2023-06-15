import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/utils/constants.dart';
import 'package:shopping_list/widgets/message_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];
  late Future<List<GroceryItem>> _loadedItems;
  var message = COMMONERRORMESSAGE;
  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(BASE_URL, "shopping-list.json");
    final response = await http.get(url);
    if (response.body == "null") {
      // snapshot.data!.isEmpty
      return [];
    }

    if (response.statusCode >= 400) {
      // snapshot.hasError
      throw Exception(ERRORMESSAGE404);
    }

    final Map<String, dynamic> listMap = json.decode(response.body);
    final List<GroceryItem> _loadedItems = [];
    for (final item in listMap.entries) {
      _loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value["name"],
          quantity: item.value["quantity"],
          category: categories.entries.firstWhere((e) => e.value.name == item.value["category"]).value
      ));
    }
    // snapshot.data!.isNotEmpty
    return _loadedItems;
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) => NewItem(),)
    );
    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem!);
      });
    }
    _loadedItems = _loadItems();
    // _loadItems();
  }

  void _removeItem(GroceryItem item) async {
    final url = Uri.https(BASE_URL, "shopping-list/${item.id}.json");
    final response = await http.delete(url);
    // Firebase Delete는 삭제 성공 여부 관계 없이 200, null로 응답
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200 && context.mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Fail to delete item."),
          action: SnackBarAction(
            label: "close",
            onPressed: () {ScaffoldMessenger.of(context).clearSnackBars();}
          ),
        )
      );
      setState(() {
        // For ui update
      });
      return;
    }
    setState(() {
      _groceryItems.remove(item);
    });
    _loadedItems = _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add)
          )
        ],
      ),
      // HTTP response가 Future로 오기 떄문에 처리할 수 있는 FutureBuilder
      body: FutureBuilder(
        // future tpye으로 감지할 데이터
        future: _loadedItems,
        // future가 데이터를 생성한 뒤에 보여질 화면
        // snapshot: 현재 state에 접근하여
        builder: (context, snapshot) {
          // Future의 current state의 따른 widget 표시
          // state가 waiting 일 때
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          // future에서 에러가 발생했을 때
          if (snapshot.hasError) {
            // return MessageScreen(message: message);
            return MessageScreen(message: snapshot.error.toString());
          }
          // 데이터가 있을 때
          if (snapshot.hasData) {
            // 빈 데이터일 때
            if (snapshot.data!.isEmpty) {
              return const MessageScreen(message: EMPTYMESSAGE);
            }
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: _groceryItems.length,
                // SwipeToDelete를 위한 Dismissible
                itemBuilder: (context, index) => Dismissible(
                  key:  UniqueKey(),// ValueKey(_groceryItems[index]),
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.red,),
                  onDismissed: (direction) {
                    _removeItem(_groceryItems[index]);
                  },
                  child: ListTile(
                    leading: Container(
                      width: 24,
                      height: 24,
                      color: _groceryItems[index].category.color,
                    ),
                    title: Text(_groceryItems[index].name),
                    trailing: Text("${_groceryItems[index].quantity}"),
                  ),
                ),
              );
            }
          }
          return const MessageScreen(message: EMPTYMESSAGE);
        },
      ),
    );
  }
}

