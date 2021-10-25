import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screens/places_list_screen.dart';
import '../screens/add_place_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData().copyWith(
            primaryColor: Colors.indigo,
            colorScheme: ThemeData.light().colorScheme.copyWith(
                  primary: Colors.indigo,
                  secondary: Colors.amber,
                )),
        // darkTheme: ThemeData.dark().copyWith(
        //     primaryColor: Colors.indigo,
        //     colorScheme: ThemeData.dark().colorScheme.copyWith(
        //           primary: Colors.indigo,
        //           secondary: Colors.amber,
        //         )),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
