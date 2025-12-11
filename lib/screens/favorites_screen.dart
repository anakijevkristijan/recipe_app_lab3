import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/favorites_manager.dart';
import '../widgets/meal_grid_item.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoritesManager favoritesManager = FavoritesManager();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Recipes")),
      body: ValueListenableBuilder<List<Meal>>(
        valueListenable: favoritesManager.favoriteMeals,
        builder: (context, favoriteMeals, child) {
          if (favoriteMeals.isEmpty) {
            return const Center(child: Text("No favorite recipes yet."));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: favoriteMeals.length,
            itemBuilder: (context, index) {
              final meal = favoriteMeals[index];
              return MealGridItem(
                meal: meal,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MealDetailScreen(mealId: meal.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}