import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key, required this.favoriteMeals})
      : super(key: key);

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isEmpty
        ? Center(
            child: Text('You have no favorites yet - start adding some!'),
          )
        : ListView.builder(
            itemCount: favoriteMeals.length,
            itemBuilder: (ctx, i) {
              return MealItem(
                id: favoriteMeals[i].id,
                title: favoriteMeals[i].title,
                imageUrl: favoriteMeals[i].imageUrl,
                affordability: favoriteMeals[i].affordability,
                complexity: favoriteMeals[i].complexity,
                duration: favoriteMeals[i].duration,
              );
            },
          );
  }
}
