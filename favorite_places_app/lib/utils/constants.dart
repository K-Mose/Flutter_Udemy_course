const MAP_API_KEYS = "";
const API_GOOGLE_GEO_URL = "https://maps.googleapis.com/maps/api/geocode/json";
const API_GOOGLE_MAP_STATIC_URL = "https://maps.googleapis.com/maps/api/staticmap";

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