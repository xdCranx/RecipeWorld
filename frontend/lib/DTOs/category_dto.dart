class CategoryDTO {
  int id;
  String name;

  CategoryDTO({required this.id, required this.name});

  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDTO(
      id: json['id'],
      name: json['name'],
    );
  }
}