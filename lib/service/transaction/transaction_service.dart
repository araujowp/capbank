// ignore_for_file: avoid_print

import 'package:capbank/service/balance/transaction_dto.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("transaction");

  Future<bool> add(TransactionDto transactionDto) async {
    try {
      final newTransactionRef = _dbRef.push();
      print("Chave gerada: ${newTransactionRef.key}");

      await newTransactionRef.set({
        "id": newTransactionRef.key,
        "description": transactionDto.category,
        "amount": transactionDto.amount,
        "transaction_date": transactionDto.transactionDate,
        "category": transactionDto.category,
        "user_id": transactionDto.userId
      });

      return true;
    } catch (e) {
      print("Falha ao adicionar lançamento $e ");
      return false;
    }
  }
}
