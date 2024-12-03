 import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'OrderTrackingPage.dart'; // Import OrderTrackingPage

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('notification').doc('notification1').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                'No notifications available.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final notification = snapshot.data!;

          return ListView(
            children: [
              ListTile(
                title: Text(notification['title'] ?? 'No Title'),
                subtitle: Text(notification['description'] ?? 'No Description'),
                trailing: notification['type'] == 'Order Tracking'
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderTrackingPage(orderId: notification['orderId']),
                            ),
                          );
                        },
                        child: const Text('Track Order'),
                      )
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}