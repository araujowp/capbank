class CategoryDTO {
  final String description;
  final String id;
  final int type;

  CategoryDTO(
      {required this.description, //
      required this.id, //
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'id': id,
      'type': type,
    };
  }

  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDTO(
      description: json['description'] as String,
      id: json['id'] as String,
      type: json['type'] as int,
    );
  }
}
