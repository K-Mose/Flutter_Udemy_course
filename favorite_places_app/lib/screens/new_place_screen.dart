import 'dart:io';

import 'package:favorite_places_app/model/place.dart';
import 'package:favorite_places_app/providers/place_provider.dart';
import 'package:favorite_places_app/widgets/image_input.dart';
import 'package:favorite_places_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerWidget {
  NewPlaceScreen({Key? key}) : super(key: key);
  static const routeName = "/newPlace";
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = "";
  File? _selectedImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(placeProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Title")
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground
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
              // Image Input
              const SizedBox(height: 16,),
              ImageInput(onPickImage: (image) {
                _selectedImage = image;
              },),
              const SizedBox(height: 16,),
              LocationInput(),
              const SizedBox(height: 10,),
              ElevatedButton.icon(
                onPressed: () {
                  // Adding image validation
                  if (_formKey.currentState!.validate() || _selectedImage != null) {
                    _formKey.currentState!.save();
                    notifier.addPlace(Place(
                      title: _enteredTitle,
                      image: _selectedImage!
                    ));
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Place")
              )
            ]
          ),
        ),
      ),
    );
  }
}
