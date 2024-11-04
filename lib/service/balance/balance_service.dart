import 'package:capbank/service/balance/balance_dto.dart';
import 'package:capbank/service/balance/transaction_dto.dart';

class BalanceService {
  final List<BalanceDTO> _balances = [
    BalanceDTO(
      amount: 1500.23,
      date: '2024-10-01',
      transactions: [
        TransactionDto(
          amount: 2.00,
          description: 'Sessão 3 unidade 2',
          category: 'Duolingo Unidade',
          operation: 'Crédito',
        ),
        TransactionDto(
          amount: 0.50,
          description: 'Bom comportamento',
          category: 'Manhã',
          operation: 'Crédito',
        ),
        TransactionDto(
          amount: 2.00,
          description: 'Final master chef 5',
          category: 'Aposta',
          operation: 'Credito',
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
          category: 'Duolingo Unidade',
          operation: 'Crédito',
        ),
        TransactionDto(
          amount: 50.00,
          description: 'Capa do tablet',
          category: 'Compra',
          operation: 'Débito',
        ),
      ],
    ),
    BalanceDTO(
      amount: -3509.76,
      date: '2024-10-03',
      transactions: [],
    ),
  ];

  Future<BalanceDTO> getBalance(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _balances[id - 1];
  }
}
