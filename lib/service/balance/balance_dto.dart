import 'package:capbank/service/balance/transaction_dto.dart';

class BalanceDTO {
  final double amount;
  final String date;
  final List<TransactionDto> transactions;

  BalanceDTO(
      {required this.amount, //
      required this.date, //
      required this.transactions //
      });
}
