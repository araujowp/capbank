import 'package:capbank/service/transaction/transaction_dto.dart';

class BalanceDTO {
  final double amount;
  final DateTime date;
  final List<TransactionDto> transactions;

  BalanceDTO(
      {required this.amount, //
      required this.date, //
      required this.transactions //
      });
}
