import 'package:flutter/material.dart';

import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> data) {
    setState(() {
      _filters = data;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() => _favoriteMeals.removeAt(existingIndex));
    } else {
      setState(() => _favoriteMeals
          .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId)));
    }
  }

  bool _isMealFavorite(String mealId) =>
      _favoriteMeals.any((meal) => meal.id == mealId);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: Colors.pink,
              secondary: Colors.amber,
            ),
        fontFamily: 'Raleway',
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontFamily: 'Raleway', fontSize: 20)),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: const CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
            toggleFavorite: _toggleFavorite, isMealFavorite: _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              currentFilters: _filters,
              setFilters: _setFilters,
            ),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (ctx) => const CategoriesScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
