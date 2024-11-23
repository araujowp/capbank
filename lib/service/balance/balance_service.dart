// ignore_for_file: avoid_print

import 'package:capbank/service/balance/balance_dto.dart';
import 'package:capbank/service/transaction/transaction_dto.dart';
import 'package:capbank/service/transaction/transaction_service.dart';

class BalanceService {
  Future<BalanceDTO> getBalance(String userId, DateTime transactionDate) async {
    print('chegamos no balance service ?');
    final transactionService = TransactionService();

    List<TransactionDto> transactions = await transactionService
        .getByUserIdandTransactionDate(userId, transactionDate);

    print('temos $transactions.length no balance service ');
    double totalAmount = transactions.fold(0.0,
        (previousValue, transaction) => previousValue + transaction.amount);

    return BalanceDTO(
      amount: totalAmount,
      date: transactionDate.toString(),
      transactions: transactions,
    );
  }
}
