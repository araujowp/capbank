// ignore_for_file: avoid_print

import 'package:capbank/service/balance/balance_dto.dart';
import 'package:capbank/service/transaction/transaction_dto.dart';
import 'package:capbank/service/transaction/transaction_service.dart';

class BalanceService {
  Future<BalanceDTO> getBalance(String userId, DateTime transactionDate) async {
    final transactionService = TransactionService();

    List<TransactionDto> transactions = await transactionService
        .getByUserIdandTransactionDate(userId, transactionDate);

    double totalAmount = transactions.fold(0.0, (previousValue, transaction) {
      return transaction.category.type == 1
          ? previousValue + transaction.amount
          : previousValue - transaction.amount;
    });

    List<TransactionDto> filteredTransactions =
        transactions.where((transaction) {
      return transaction.transactionDate == transactionDate;
    }).toList();

    return BalanceDTO(
      amount: totalAmount,
      date: transactionDate,
      transactions: filteredTransactions,
    );
  }
}
