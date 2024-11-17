// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'category_dto_new.dart';

class CategoryService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("category");

  Future<bool> add(CategoryDTONew category) async {
    try {
      final newCategoryRef =
          _dbRef.push(); // Gera uma chave única para o registro

      print("Chave gerada: ${newCategoryRef.key}");
      await newCategoryRef.set({
        "id": newCategoryRef.key,
        "description": category.description,
        "type": category.type,
      });
      print('categoria gerada com sucesso !');
      return true;
    } catch (e) {
      print("Erro ao adicionar categoria: $e");
      return false;
    }
  }
}
