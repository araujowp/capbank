class CategoryDTONew {
  final String description;
  final int type;
  double sugestedValue;

  CategoryDTONew(
      {required this.description, //
      required this.type,
      this.sugestedValue = 0.00 //
      });
}
