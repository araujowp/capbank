// ignore_for_file: avoid_print

//import 'dart:ffi';

import 'package:capbank/service/category/category_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'category_dto_new.dart';

class CategoryService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("category");

  // Método para autenticar anonimamente
  Future<void> _authenticateAnonymously() async {
    try {
      User? user = FirebaseAuth
          .instance.currentUser; // Verifica se o usuário já está autenticado
      if (user == null) {
        await FirebaseAuth.instance.signInAnonymously(); // Autenticação anônima
        print("Usuário autenticado anonimamente.");
      } else {
        print("Usuário já autenticado: \${user.uid}");
      }
    } catch (e) {
      print("Erro ao autenticar anonimamente: \$e");
      rethrow; // Propaga o erro se necessário
    }
  }

  Future<bool> add(CategoryDTONew category) async {
    try {
      await _authenticateAnonymously();
      final snapshot = await _dbRef
          .orderByChild('description')
          .equalTo(category.description)
          .get();

      if (snapshot.exists) {
        return false;
      }

      final newCategoryRef = _dbRef.push();

      await newCategoryRef.set({
        "id": newCategoryRef.key,
        "description": category.description,
        "type": category.type,
        "sugestedValue": category.sugestedValue
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<CategoryDTO>> getByType(int type) async {
    try {
      await _authenticateAnonymously();
      final snapshot = await _dbRef.orderByChild('type').equalTo(type).get();

      List<CategoryDTO> categories = [];
      for (var child in snapshot.children) {
        categories.add(CategoryDTO(
          description: child.child('description').value.toString(),
          id: child.child('id').value.toString(),
          type: int.parse(child.child('type').value.toString()),
          sugestedValue: double.tryParse(
                  child.child('sugestedValue').value?.toString() ?? '0.0') ??
              0.0,
        ));
      }
      categories.sort((a, b) => a.description.compareTo(b.description));
      return categories;
    } catch (e) {
      return [];
    }
  }
}
