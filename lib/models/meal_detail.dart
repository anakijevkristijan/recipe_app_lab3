class MealDetail {
  final String id;
  final String name;
  final String thumbnail;
  final String instructions;
  final String youtubeUrl;
  final List<String> ingredients;

  MealDetail({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.instructions,
    required this.youtubeUrl,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredientsList = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredientsList.add('$ingredient ($measure)');
      }
    }

    return MealDetail(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
      instructions: json['strInstructions'],
      youtubeUrl: json['strYoutube'] ?? '',
      ingredients: ingredientsList,
    );
  }
}