import 'package:capbank/service/balance/balance_dto.dart';
import 'package:capbank/service/balance/transaction_dto.dart';
import 'package:capbank/service/category/category_dto.dart';

class BalanceService {
  final List<BalanceDTO> _balances = [
    BalanceDTO(
      amount: 1500.23,
      date: '2024-10-01',
      transactions: [
        TransactionDto(
          amount: 2.00,
          description: 'Sessão 3 unidade 2',
          transactionDate: DateTime.now(),
          category: CategoryDTO(
              description: 'Duolindo unidade', id: 'compra1', type: 1),
          userId: '1',
        ),
        TransactionDto(
          amount: 0.50,
          description: 'Bom comportamento',
          transactionDate: DateTime.now(),
          category: CategoryDTO(description: 'Manhã', id: 'compra1', type: 1),
          userId: '1',
        ),
        TransactionDto(
          amount: 2.00,
          description: 'Final master chef 5',
          transactionDate: DateTime.now(),
          category: CategoryDTO(description: 'Aposta', id: 'compra1', type: 1),
          userId: '1',
        )
      ],
    ),
    BalanceDTO(
      amount: 2501.48,
      date: '2024-10-02',
      transactions: [
        TransactionDto(
          amount: 20.00,
          description: 'Unidade 13 sessão 3',
          transactionDate: DateTime.now(),
          category: CategoryDTO(
              description: 'Unidade Duolindo', id: 'compra1', type: 1),
          userId: '2',
        ),
        TransactionDto(
          amount: 50.00,
          description: 'Capa do tablet',
          transactionDate: DateTime.now(),
          category: CategoryDTO(description: 'compra', id: 'compra1', type: 2),
          userId: '2',
        ),
      ],
    ),
    BalanceDTO(
      amount: -3509.76,
      date: '2024-10-03',
      transactions: [],
    ),
  ];

  Future<BalanceDTO> getBalance(String userId, DateTime transactionDate) async {
    await Future.delayed(const Duration(seconds: 1));

    // Filtra o balanço com base no userId e na data
    final filteredBalances = _balances.where((balance) {
      return balance.transactions.any((transaction) =>
          transaction.userId == userId &&
              transaction.transactionDate.isBefore(transactionDate) ||
          transaction.transactionDate.isAtSameMomentAs(transactionDate));
    }).toList();

    if (filteredBalances.isNotEmpty) {
      return filteredBalances.first;
    }

    return BalanceDTO(
      amount: 0.0,
      date: DateTime.now().toString(),
      transactions: [],
    );
  }
}
