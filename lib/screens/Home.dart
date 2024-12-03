import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kmwd/screens/Nortification/NotificationsPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int unreadNotificationsCount = 0;

  @override
  void initState() {
    super.initState();
    _getUnreadNotificationsCount();
  }

  // Fetch unread notifications count
  void _getUnreadNotificationsCount() async {
    FirebaseFirestore.instance
        .collection('notification')
        .where('isRead', isEqualTo: false)
        .get()
        .then((querySnapshot) {
      setState(() {
        unreadNotificationsCount = querySnapshot.size;
      });
    });
  }

  // Method to mark a notification as read
  void _markAsRead(String docId) async {
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(docId)
        .update({'isRead': true}).then((value) {
      _getUnreadNotificationsCount();
    });

    Fluttertoast.showToast(msg: "Notification marked as read!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DecorIT',
          style: TextStyle(
            color: Colors.white, // Replace with your font family name
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 204, 16, 16),
        actions: [
          // Notification icon with count indicator
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
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
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/wallArt.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.all(4),
                        child: const Text(
                          'Wall Arts',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/sale.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              'Summer Sale',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              image: const DecorationImage(
                                image: AssetImage('assets/images/bed.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: const Stack(
                              children: [
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Text(
                                    'White',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                              image: const DecorationImage(
                                image: AssetImage('assets/images/01.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: const Stack(
                              children: [
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Text(
                                    'Black',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
