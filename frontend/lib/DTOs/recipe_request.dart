class RecipeRequest {
  final String userId;
  final int categoryId;
  final String title;
  final String description;
  final List<Map<String, dynamic>> ingredients;
  //first is id and second is quantity
  final int prepTime;

  RecipeRequest({
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.prepTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'prepTime': prepTime,
    };
  }
}