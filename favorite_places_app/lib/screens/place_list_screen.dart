import 'package:favorite_places_app/providers/place_provider.dart';
import 'package:favorite_places_app/screens/new_place_screen.dart';
import 'package:favorite_places_app/screens/place_detail_screen.dart';
import 'package:favorite_places_app/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/place.dart';

class PlaceListScreen extends ConsumerStatefulWidget {
  const PlaceListScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  ConsumerState createState() {
    return _PlaceScreenState();
  }
}
class _PlaceScreenState extends ConsumerState<PlaceListScreen> {
  late Future<void> _placeFuture;

  @override
  void initState() {
    _placeFuture = ref.read(placeProvider.notifier).loadPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Place> placeList = ref.watch(placeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Place"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NewPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(5),
          child: FutureBuilder(
            future: _placeFuture,
            builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator(),)
                  : PlacesList(placeList: placeList)
          )
      ),
    );
  }
}
