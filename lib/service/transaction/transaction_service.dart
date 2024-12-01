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
      return false;
    }
  }

  Future<List<TransactionDto>> getByUserIdandTransactionDate(
      String userId, DateTime period) async {
    List<TransactionDto> transactions = [];

    try {
      final query = _dbRef.orderByChild("user_id").equalTo(userId);
      final snapshot = await query.once();
      if (snapshot.snapshot.value != null) {
        // Cast explícito para Map<String, dynamic> no nível principal
        final data = Map<String, dynamic>.from(
            snapshot.snapshot.value as Map<Object?, Object?>);
        data.forEach((key, value) {
          // Cast explícito para Map<String, dynamic> para cada entrada
          final transactionData =
              Map<String, dynamic>.from(value as Map<Object?, Object?>);
          final transactionDate = DateTime.fromMillisecondsSinceEpoch(
              transactionData["transaction_date"]);
          if (transactionDate.isBefore(period) ||
              transactionDate.isAtSameMomentAs(period)) {
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
