import 'package:favorite_places_app/model/place.dart';
import 'package:favorite_places_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';

String locationImage(PlaceLocation? location) {
  if (location == null) {
    return '';
  }
  final lat = location.latitude;
  final long = location.longitude;
  return "$API_GOOGLE_MAP_STATIC_URL?center=$lat,$long&zoom=16"
  // label: 마커에서 보일 라벨
      "&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long"
      "&key=$MAP_API_KEYS";
}

T? cast<T>(x) => x is T ? x : null;

void operatingNotNull<T>(T? t,Function(BuildContext context) process, BuildContext ctx) {
  t is T ? process(ctx) : null;
}