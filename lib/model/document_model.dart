// lib/models/document_model.dart
class DocumentModel {
  final String panNumber;
  final String aadhaarNumber;
  final double monthlyIncome;

  DocumentModel({
    required this.panNumber,
    required this.aadhaarNumber,
    required this.monthlyIncome,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      panNumber: json['panNumber'] ?? '',
      aadhaarNumber: json['aadhaarNumber'] ?? '',
      monthlyIncome: (json['monthlyIncome'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'panNumber': panNumber,
      'aadhaarNumber': aadhaarNumber,
      'monthlyIncome': monthlyIncome,
    };
  }
}
