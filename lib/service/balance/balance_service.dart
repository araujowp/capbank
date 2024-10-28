import 'package:capbank/service/balance/balance_dto.dart';
import 'package:capbank/service/balance/transaction_dto.dart';

class BalanceService {
  final List<BalanceDTO> _balances = [
    BalanceDTO(
      amount: 1500.23,
      date: '2024-10-01',
      transactions: [
        TransactionDto(
          amount: 200.00,
          description: 'Compra de supermercado',
          category: 'Alimentação',
          operation: 'Débito',
        ),
      ],
    ),
    BalanceDTO(
      amount: 2501.48,
      date: '2024-10-02',
      transactions: [
        TransactionDto(
          amount: 300.00,
          description: 'Pagamento de contas',
          category: 'Contas',
          operation: 'Débito',
        ),
        TransactionDto(
          amount: 937.56,
          description: 'Salário recebido',
          category: 'Renda',
          operation: 'Crédito',
        ),
      ],
    ),
    BalanceDTO(
      amount: 3500.00,
      date: '2024-10-03',
      transactions: [
        TransactionDto(
          amount: 50.00,
          description: 'Taxa de serviço',
          category: 'Serviços',
          operation: 'Débito',
        ),
      ],
    ),
  ];

  Future<BalanceDTO> getBalance(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _balances[id - 1];
  }
}
