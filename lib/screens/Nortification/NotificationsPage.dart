import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'OrderTrackingPage.dart'; // Import OrderTrackingPage

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications',
            style: TextStyle(
              color: Colors.white, // Replace with your font family name
            )),
        backgroundColor: const Color.fromARGB(255, 204, 16, 16),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('notification').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No notifications available.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              bool isRead = notification['isRead'] ?? false;

              return ListTile(
                title: Text(notification['title'] ?? 'No Title'),
                subtitle: Text(notification['description'] ?? 'No Description'),
                trailing: notification['type'] == 'Order Tracking'
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderTrackingPage(
                                  orderId: notification['orderId']),
                            ),
                          );
                        },
                        child: const Text('Track Order'),
                      )
                    : null,
                onTap: () {
                  // Mark notification as read
                  FirebaseFirestore.instance
                      .collection('notification')
                      .doc(notification.id)
                      .update({'isRead': true});
                },
                tileColor: isRead
                    ? Colors.white
                    : Colors.yellow[100], // Highlight unread notifications
              );
            },
          );
        },
      ),
    );
  }
}
