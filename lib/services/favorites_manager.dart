import 'package:flutter/foundation.dart';
import '../models/meal.dart';

class FavoritesManager {
  // Singleton pattern
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final ValueNotifier<List<Meal>> _favoriteMeals = ValueNotifier([]);

  ValueNotifier<List<Meal>> get favoriteMeals => _favoriteMeals;

  void toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.value.any((element) => element.id == meal.id);

    List<Meal> currentList = List.from(_favoriteMeals.value);

    if (isExisting) {
      currentList.removeWhere((element) => element.id == meal.id);
    } else {
      currentList.add(meal);
    }

    _favoriteMeals.value = currentList;
  }

  bool isFavorite(String id) {
    return _favoriteMeals.value.any((element) => element.id == id);
  }
}