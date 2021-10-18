import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  const CategoryMealsScreen({Key? key}) : super(key: key);

  static const routeName = '/category-meals';

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'].toString();
      categoryTitle = routeArgs['title'].toString();
      displayedMeals = DUMMY_MEALS
          .where((meal) => meal.categories.contains(categoryId))
          .toList();

      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemCount: displayedMeals.length,
        itemBuilder: (ctx, i) {
          return MealItem(
            id: displayedMeals[i].id,
            title: displayedMeals[i].title,
            imageUrl: displayedMeals[i].imageUrl,
            affordability: displayedMeals[i].affordability,
            complexity: displayedMeals[i].complexity,
            duration: displayedMeals[i].duration,
            removeItem: _removeMeal,
          );
        },
      ),
    );
  }
}
