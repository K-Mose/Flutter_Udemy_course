import 'package:favorite_places_app/model/place.dart';
import 'package:favorite_places_app/providers/place_provider.dart';
import 'package:favorite_places_app/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key, required this.placeList});

  final List<Place> placeList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (placeList.isEmpty)
        ? Center(child: Text(
      "No places added yet",
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground
      ),
    )
    )
        : ListView.builder(
      itemCount: placeList.length,
      itemBuilder: (context, index) =>
          Dismissible(
            onDismissed: (direction) {
              ref.read(placeProvider.notifier).removePlace(placeList[index]);
            },
            key: ValueKey(placeList[index]),
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                    PlaceDetailScreen.routeName,
                    arguments: placeList[index]
                );
              },
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(placeList[index].image),
              ),
              title: Text(
                placeList[index].title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
    );
  }
}
