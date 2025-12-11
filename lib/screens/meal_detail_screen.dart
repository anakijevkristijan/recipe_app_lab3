import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_detail.dart';
import '../models/meal.dart';
import '../services/favorites_manager.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({Key? key, required this.mealId}) : super(key: key);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService apiService = ApiService();
  final FavoritesManager favoritesManager = FavoritesManager();
  MealDetail? mealDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  void fetchDetail() async {
    try {
      var data = await apiService.fetchMealDetail(widget.mealId);
      setState(() {
        mealDetail = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetail?.name ?? 'Details'),
        actions: [
          if (mealDetail != null)
            ValueListenableBuilder<List<Meal>>(
              valueListenable: favoritesManager.favoriteMeals,
              builder: (context, favorites, child) {
                final isFav = favoritesManager.isFavorite(mealDetail!.id);
                return IconButton(
                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                  color: isFav ? Colors.red : Colors.white,
                  onPressed: () {
                    // Креираме Meal објект од MealDetail за да го зачуваме
                    Meal mealToSave = Meal(
                        id: mealDetail!.id,
                        name: mealDetail!.name,
                        thumbnail: mealDetail!.thumbnail
                    );
                    favoritesManager.toggleFavorite(mealToSave);
                  },
                );
              },
            )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              mealDetail!.thumbnail,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ingredients:',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...mealDetail!.ingredients.map(
                          (e) => Text('• $e', style: const TextStyle(fontSize: 16))),
                  const SizedBox(height: 20),
                  const Text(
                    'Instructions:',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(mealDetail!.instructions,
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  if (mealDetail!.youtubeUrl.isNotEmpty)
                    Text(
                      'YouTube: ${mealDetail!.youtubeUrl}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}