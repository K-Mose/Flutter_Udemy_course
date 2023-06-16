import 'package:favorite_places_app/model/place.dart';
import 'package:favorite_places_app/screens/new_place_screen.dart';
import 'package:favorite_places_app/screens/place_detail_screen.dart';
import 'package:favorite_places_app/screens/place_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  background: const Color.fromARGB(255, 56, 49, 66),
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const PlaceListScreen(),
      initialRoute: PlaceListScreen.routeName,
      routes: <String, WidgetBuilder> {
        NewPlaceScreen.routeName: (context) => NewPlaceScreen()
      },
      onGenerateRoute: (settings) {
        if (settings.name == PlaceDetailScreen.routeName) {
          final place = settings.arguments! as Place;
          return MaterialPageRoute(builder: (context) {
            return PlaceDetailScreen(place: place);
          });
        }
      },
    );
  }
}