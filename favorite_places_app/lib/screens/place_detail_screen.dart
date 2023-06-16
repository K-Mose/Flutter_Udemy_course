import 'package:favorite_places_app/model/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key, required this.place}) : super(key: key);
  static const routeName = "/placeDetail";
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              place.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
              ),
            ),
            Image.file(place.image)
          ]
        ),
      ),
    );
  }
}
