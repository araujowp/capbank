class CategoryDTO {
  final String description;
  final String id;
  final int type;
  double sugestedValue = 0.0;

  CategoryDTO(
      {required this.description, //
      required this.id, //
      required this.type,
      this.sugestedValue = 0.00});

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'id': id,
      'type': type,
      'sugestedValue': sugestedValue
    };
  }

  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDTO(
        description: json['description'] as String,
        id: json['id'] as String,
        type: json['type'] as int,
        sugestedValue: (json['sugestedValue'] is int)
            ? (json['sugestedValue'] as int).toDouble()
            : json['sugestedValue'] as double);
  }
}
