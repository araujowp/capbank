import 'package:firebase_database/firebase_database.dart';
import 'category_dto_new.dart';

class CategoryService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("category");

  Future<void> add(CategoryDTONew category) async {
    final newCategoryRef =
        _dbRef.push(); // Gera uma chave única para o registro

    await newCategoryRef.set({
      "id": newCategoryRef.key,
      "description": category.description,
      "type": category.type,
    });
  }
}
