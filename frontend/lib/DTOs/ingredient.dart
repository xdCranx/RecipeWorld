class Ingredient {
  int id;
  String name;
  String unit;

  Ingredient ({
    required this.id,
    required this.name,
    required this.unit
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      unit: json['unit']
    );
  }
}