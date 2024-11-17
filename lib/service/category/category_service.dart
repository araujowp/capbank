// ignore_for_file: avoid_print

import 'package:capbank/service/category/category_dto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'category_dto_new.dart';

class CategoryService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("category");

  Future<bool> add(CategoryDTONew category) async {
    try {
      final snapshot = await _dbRef
          .orderByChild('description')
          .equalTo(category.description)
          .get();

      if (snapshot.exists) {
        print("Categoria com a descrição '${category.description}' já existe.");
        return false;
      }

      final newCategoryRef =
          _dbRef.push(); // Gera uma chave única para o registro

      print("Chave gerada: ${newCategoryRef.key}");
      await newCategoryRef.set({
        "id": newCategoryRef.key,
        "description": category.description,
        "type": category.type,
      });
      return true;
    } catch (e) {
      print("Erro ao adicionar categoria: $e");
      return false;
    }
  }

  Future<List<CategoryDTO>> getByType(int type) async {
    try {
      final snapshot = await _dbRef
          .orderByChild('description')
          .equalTo(type) // Filtra pelo tipo fornecido
          .get();

      List<CategoryDTO> categories = [];
      for (var child in snapshot.children) {
        categories.add(CategoryDTO(
          description: child.child('description').value.toString(),
          id: child.child('id').value.toString(),
        ));
      }

      return categories;
    } catch (e) {
      print("Erro ao buscar categorias: $e");
      return [];
    }
  }
}
