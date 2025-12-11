import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/favorites_manager.dart';

class MealGridItem extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  const MealGridItem({Key? key, required this.meal, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesManager = FavoritesManager();

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(meal.thumbnail, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                  color: Colors.black54,
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Text(
                  meal.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: ValueListenableBuilder<List<Meal>>(
                valueListenable: favoritesManager.favoriteMeals,
                builder: (context, favorites, child) {
                  final isFav = favoritesManager.isFavorite(meal.id);
                  return CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        favoritesManager.toggleFavorite(meal);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}