// ignore_for_file: avoid_print

import 'package:capbank/service/category/category_dto.dart';
import 'package:capbank/service/transaction/transaction_dto.dart';
import 'package:capbank/service/transaction/transaction_dto_new.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("transaction");

  Future<bool> add(TransactionDtoNew transactionDto) async {
    try {
      final newTransactionRef = _dbRef.push();
      print("Chave gerada: ${newTransactionRef.key}");

      print(transactionDto.category.toJson());

      await newTransactionRef.set({
        "id": newTransactionRef.key,
        "description": transactionDto.description,
        "amount": transactionDto.amount,
        "transaction_date":
            transactionDto.transactionDate.millisecondsSinceEpoch,
        "category": transactionDto.category.toJson(),
        "user_id": transactionDto.userId
      });

      return true;
    } catch (e) {
      print("Falha ao adicionar lançamento $e ");
      return false;
    }
  }

  Future<List<TransactionDto>> getByUserIdandTransactionDate(
      String userId, DateTime period) async {
    List<TransactionDto> transactions = [];

    try {
      print('ponto 1');
      final query = _dbRef.orderByChild("user_id").equalTo(userId);
      print('ponto 2');
      final snapshot = await query.once();
      print('ponto 3 - map string dinamic bici');
      if (snapshot.snapshot.value != null) {
        // Cast explícito para Map<String, dynamic> no nível principal
        final data = Map<String, dynamic>.from(
            snapshot.snapshot.value as Map<Object?, Object?>);
        print('ponto 4');
        data.forEach((key, value) {
          print('ponto 5');
          // Cast explícito para Map<String, dynamic> para cada entrada
          final transactionData =
              Map<String, dynamic>.from(value as Map<Object?, Object?>);
          final transactionDate = DateTime.fromMillisecondsSinceEpoch(
              transactionData["transaction_date"]);
          print('ponto 6 convertendo double');
          if (transactionDate.isBefore(period)) {
            transactions.add(TransactionDto(
              id: key,
              description: transactionData["description"],
              amount: (transactionData["amount"] as num).toDouble(),
              transactionDate: transactionDate,
              category: CategoryDTO.fromJson(Map<String, dynamic>.from(
                  transactionData["category"] as Map<Object?, Object?>)),
              userId: transactionData["user_id"],
            ));
          }
        });
      }
    } catch (e) {
      print("Erro ao buscar transações: $e");
    }

    return transactions;
  }
}
