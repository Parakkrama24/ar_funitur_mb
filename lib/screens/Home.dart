import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kmwd/screens/Nortification/NotificationsPage.dart'; // Assuming the NotificationsPage is defined in another file

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  late int unreadNotificationsCount = 0; // Track unread notifications count

  @override
  void initState() {
    super.initState();
    _getUnreadNotificationsCount();
  }

  // Fetch unread notifications count
  void _getUnreadNotificationsCount() async {
    FirebaseFirestore.instance
        .collection('notification')
        .where('isRead', isEqualTo: false) // Check unread notifications
        .get()
        .then((querySnapshot) {
      setState(() {
        unreadNotificationsCount =
            querySnapshot.size; // Set unread notification count
      });
    });
  }

  // Method to mark a notification as read
  void _markAsRead(String docId) async {
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(docId)
        .update({'isRead': true}).then((value) {
      _getUnreadNotificationsCount(); // Update the unread count after marking as read
    });

    Fluttertoast.showToast(msg: "Notification marked as read!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color.fromARGB(255, 204, 16, 16),
        actions: [
          // Notification icon with count indicator
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsPage()),
                  );
                },
              ),
              if (unreadNotificationsCount > 0)
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$unreadNotificationsCount',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
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
              final title = notification['title'] ?? 'No Title';
              final description =
                  notification['description'] ?? 'No Description';
              final type = notification['type'] ?? 'General';
              final orderId = notification['orderId'] ?? '';

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.asset(
                      'assets/images/sportdress.png'), // Image for the notification
                  title: Text(title),
                  subtitle: Text(description),
                  trailing: type == 'Order Tracking'
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderTrackingPage(orderId: orderId),
                              ),
                            );
                          },
                          child: const Text('Track Order'),
                        )
                      : null,
                  onTap: () =>
                      _markAsRead(notification.id), // Mark as read on tap
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Assuming you have OrderTrackingPage in your project, here's an example of its basic structure:

class OrderTrackingPage extends StatelessWidget {
  final String orderId;

  const OrderTrackingPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Tracking'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<DocumentSnapshot>(
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
