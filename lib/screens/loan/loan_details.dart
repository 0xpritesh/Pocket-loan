import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanDetailsScreen extends StatelessWidget {
  const LoanDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock values – later you can pull from controller or API
    final double approvedAmount = 300000;
    final double usedAmount = 125000;
    final double remaining = approvedAmount - usedAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Loan Summary',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 32),

            _buildDetailTile('Approved Amount', '₹ ${approvedAmount.toStringAsFixed(0)}', Icons.verified_outlined),
            const SizedBox(height: 16),
            _buildDetailTile('Amount Used', '₹ ${usedAmount.toStringAsFixed(0)}', Icons.trending_down_outlined),
            const SizedBox(height: 16),
            _buildDetailTile('Remaining Balance', '₹ ${remaining.toStringAsFixed(0)}', Icons.account_balance_wallet_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.indigo),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}
