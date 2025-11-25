import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_detail.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({Key? key, required this.mealId}) : super(key: key);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService apiService = ApiService();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(mealDetail?.name ?? 'Детали')),
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
                    'Состојки:',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...mealDetail!.ingredients.map(
                          (e) => Text('• $e', style: const TextStyle(fontSize: 16))),
                  const SizedBox(height: 20),
                  const Text(
                    'Инструкции:',
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