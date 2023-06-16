import 'package:favorite_places_app/model/place.dart';
import 'package:favorite_places_app/providers/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerWidget {
  NewPlaceScreen({Key? key}) : super(key: key);
  static const routeName = "/newPlace";
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = "";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(placeProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Place"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Title")
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Must be inputted.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredTitle = value!;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      notifier.addPlace(Place(
                        id: DateTime.now().toString(),
                        title: _enteredTitle
                      ));
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Place")
                )
              ],
            )
          ]
        ),
      ),
    );
  }
}
