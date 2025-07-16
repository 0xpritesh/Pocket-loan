import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DocumentController extends GetxController {
  final ImagePicker picker = ImagePicker();

  /// Reactive list for storing selected documents
  final RxList<File?> documents = List<File?>.generate(5, (_) => null).obs;

  final List<String> docNames = [
    "Aadhar Card",
    "PAN Card",
    "Salary Slip",
    "Bank Statement",
    "Photo (Selfie)"
  ];

  /// Pick document from gallery
  Future<void> pickDocument(int index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      documents[index] = File(pickedFile.path);
      documents.refresh(); // ✅ Refresh UI
    }
  }
}
