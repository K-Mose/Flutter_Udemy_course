import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {

  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  String toString() {
    return 'PlaceLocation{latitude: $latitude, longitude: $longitude, address: $address}';
  }
}

class Place {
  Place({required this.title, required this.image, required this.location}) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  @override
  String toString() {
    return 'Place{id: $id, title: $title, image: $image \nlocation: $location}';
  }
}

