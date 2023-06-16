import 'package:favorite_places_app/providers/place_provider.dart';
import 'package:favorite_places_app/screens/new_place_screen.dart';
import 'package:favorite_places_app/screens/place_detail_screen.dart';
import 'package:favorite_places_app/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/place.dart';

class PlaceListScreen extends ConsumerWidget {
  const PlaceListScreen({Key? key}) : super(key: key);
  static const routeName = "/placeList";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Place> placeList = ref.watch(placeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Place"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(
              NewPlaceScreen.routeName
            );
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: PlacesList(placeList: placeList),
    );
  }
}
