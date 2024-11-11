import 'package:flutter/material.dart';

class TotalAmountSection extends StatelessWidget {
  final int totalAmount;

  const TotalAmountSection({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total amount:', style: TextStyle(fontSize: 18)),
          Text('\$$totalAmount', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
