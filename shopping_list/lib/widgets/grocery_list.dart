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
  var _isLoading = true;
  var _isError = false;
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(BASE_URL, "shopping-list.json");
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body); // 응답 데이터 모양 체크
    if (response.statusCode == 200) {
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
      setState(() {
        _groceryItems.clear();
        _groceryItems.addAll(_loadedItems);
        _isLoading = false;
      });
    } else if (response.statusCode >= 400) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
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
    // _loadItems();
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
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
      body: (_isLoading) ? const Center(child: CircularProgressIndicator(),) :
      (_isError) ? const MessageScreen(message: ERRORMESSAGE404)  :
      (_groceryItems.isNotEmpty) ? ListView.builder(
        itemCount: _groceryItems.length,
        // SwipeToDelete를 위한 Dismissible
        itemBuilder: (context, index) => Dismissible(
          key: ObjectKey(_groceryItems[index]),
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
      ) : const MessageScreen(message: EMPTYMESSAGE),
    );
  }
}

