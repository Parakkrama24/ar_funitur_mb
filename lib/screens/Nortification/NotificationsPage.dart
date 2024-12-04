import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'OrderTrackingPage.dart'; // Import OrderTrackingPage

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _updateUnreadCount();
  }

  // Method to count unread notifications
  void _updateUnreadCount() async {
    // Fetch unread notifications from Firestore
    final snapshot = await FirebaseFirestore.instance
        .collection('notification')
        .where('isRead', isEqualTo: false)
        .get();

    setState(() {
      unreadCount = snapshot.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< Updated upstream
        title: const Text('Notifications'),
        backgroundColor: Colors.black,
=======
        title: const Text('Notifications',
            style: TextStyle(
              color: Colors.white, // Replace with your font family name
            )),
        backgroundColor: const Color.fromARGB(255, 204, 16, 16),
        automaticallyImplyLeading: true,
        centerTitle: true,
        actions: [
          // Notification Icon with unread count
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  _updateUnreadCount(); // Refresh unread count when tapped
                },
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
>>>>>>> Stashed changes
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notification').snapshots(),
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
                              builder: (context) => OrderTrackingPage(orderId: notification['orderId']),
                            ),
                          );
                        },
                        child: const Text('Track Order'),
                      )
                    : null,
                onTap: () async {
                  // Mark notification as read immediately
                  await FirebaseFirestore.instance
                      .collection('notification')
                      .doc(notification.id)
                      .update({'isRead': true});

                  // Refresh unread count after marking as read
                  _updateUnreadCount();
                },
                tileColor: isRead ? Colors.white : Colors.yellow[100], // Highlight unread notifications
              );
            },
          );
        },
      ),
    );
  }
}
