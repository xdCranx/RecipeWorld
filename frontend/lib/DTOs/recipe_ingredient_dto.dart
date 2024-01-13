class RecipeIngredientDTO {
  int id;
  String name;
  String unit;
  double quantity;

  RecipeIngredientDTO({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
  });

  factory RecipeIngredientDTO.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientDTO(
      id: json['id'],
      name: json['name'],
      unit: json['unit'],
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
