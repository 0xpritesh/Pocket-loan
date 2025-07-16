import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketloan/controller/document_controller.dart';
import 'package:pocketloan/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentVerificationScreen extends StatefulWidget {
  const DocumentVerificationScreen({super.key});

  @override
  State<DocumentVerificationScreen> createState() =>
      _DocumentVerificationScreenState();
}

class _DocumentVerificationScreenState
    extends State<DocumentVerificationScreen> {
  final DocumentController docController = Get.put(DocumentController());

  Future<void> submitDocuments() async {
    if (docController.documents.any((doc) => doc == null)) {
      Get.snackbar("Error", "Please upload all documents",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDocumentVerified', true); // ✅ Save status
    Get.offAllNamed(AppRoutes.dashboardScreen); // ✅ Navigate to Dashboard
  }

  Future<void> pickDocument(int index) async {
    await docController.pickDocument(index);
    setState(() {}); // ✅ Refresh UI manually
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document Verification"),
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Upload the following documents:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              /// ✅ List of documents
              Expanded(
                child: ListView.builder(
                  itemCount: docController.docNames.length,
                  itemBuilder: (context, index) {
                    final doc = docController.documents[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: doc == null
                            ? const Icon(Icons.upload_file,
                                color: Colors.indigo, size: 32)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  File(doc.path),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        title: Text(
                          docController.docNames[index],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: doc == null
                            ? const Text("No file selected",
                                style: TextStyle(color: Colors.red))
                            : const Text("File uploaded ✅",
                                style: TextStyle(color: Colors.green)),
                        trailing: ElevatedButton.icon(
                          onPressed: () => pickDocument(index),
                          icon: const Icon(Icons.add_a_photo, size: 18),
                          label: const Text("Upload"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// ✅ Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitDocuments,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Submit & Continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
