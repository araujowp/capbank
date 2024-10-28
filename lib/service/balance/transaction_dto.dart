class TransactionDto {
  final double amount;
  final String description;
  final String category;
  final String operation;

  // Construtor
  TransactionDto({
    required this.amount,
    required this.description,
    required this.category,
    required this.operation,
  });

  @override
  String toString() {
    return 'TransactionDto( amount: $amount, description: $description, category: $category, operation: $operation)';
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'category': category,
      'operation': operation,
    };
  }

  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      amount: json['amount'] as double,
      description: json['description'] as String,
      category: json['category'] as String,
      operation: json['operation'] as String,
    );
  }
}
