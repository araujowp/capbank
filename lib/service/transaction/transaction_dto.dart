import 'package:capbank/service/category/category_dto.dart';

class TransactionDto {
  final String id;
  final String description;
  final double amount;
  final DateTime transactionDate;
  final CategoryDTO category;
  final String userId;

  // Construtor
  TransactionDto({
    required this.id,
    required this.description,
    required this.amount,
    required this.transactionDate,
    required this.category,
    required this.userId,
  });

  @override
  String toString() {
    return 'TransactionDto( amount: $amount, description: $description, category: $category, transactionDate: $transactionDate, userId $userId )';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'category': category,
      'transactionDate': transactionDate,
      'userId': userId,
    };
  }

  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      id: json['id'] as String,
      description: json['description'] as String,
      amount: json['amount'] as double,
      category: json['category'] as CategoryDTO,
      transactionDate: json['transactionDate'] as DateTime,
      userId: json['userId'],
    );
  }
}
