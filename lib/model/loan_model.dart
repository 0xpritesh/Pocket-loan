class LoanModel {
  final String id;
  final String userId;
  final double amount;
  late final String status;
  final List<String> documents;
  final int months;
  final double interestRate;

  LoanModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.status,
    required this.documents,
    this.months = 12,
    this.interestRate = 10.0,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      documents: List<String>.from(json['documents'] ?? []),
      months: json['months'] ?? 12,
      interestRate: (json['interestRate'] ?? 10).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'amount': amount,
        'status': status,
        'documents': documents,
        'months': months,
        'interestRate': interestRate,
      };
}
