import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderTrackingPage extends StatelessWidget {
  final String orderId; // Receive the order ID

  const OrderTrackingPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Tracking',
            style: TextStyle(
              color: Colors.white, // Replace with your font family name
            )),
        backgroundColor: const Color.fromARGB(255, 204, 16, 16),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        // Query the 'orders' collection and the document with the provided orderId
        future:
            FirebaseFirestore.instance.collection('orders').doc(orderId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                'Order not found.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final orderData = snapshot.data!.data() as Map<String, dynamic>;

          // Debugging: Print the data for verification
          print('Order Data: $orderData');

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID: $orderId',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Status: ${orderData['status'] ?? 'Unknown'}'),
                const SizedBox(height: 10),
                Text(
                    'Estimated Delivery: ${orderData['estimatedDelivery'] ?? 'Unknown'}'),
                const SizedBox(height: 10),
                Text(
                  'Items: ${orderData['items'] != null && orderData['items'] is List ? (orderData['items'] as List).join(', ') : 'No items listed.'}',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
