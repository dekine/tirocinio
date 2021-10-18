import 'package:flutter/material.dart';

import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key, required this.favoriteMeals})
      : super(key: key);

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('You have no favorites yet - start adding some!'),
    );
  }
}
