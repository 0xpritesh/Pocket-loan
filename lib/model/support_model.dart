// lib/models/support_model.dart
class SupportRequest {
  final String id;
  final String userEmail;
  final String message;

  SupportRequest({
    required this.id,
    required this.userEmail,
    required this.message,
  });

  factory SupportRequest.fromJson(Map<String, dynamic> json) {
    return SupportRequest(
      id: json['id'],
      userEmail: json['userEmail'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userEmail': userEmail,
      'message': message,
    };
  }
}
