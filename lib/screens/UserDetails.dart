import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kmwd/componnets/profilePage/UpdareProfileButton.dart';

class Userdetails extends StatefulWidget {
  const Userdetails({super.key});

  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when the widget initializes
  }

  Future<void> fetchUserData() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (doc.exists) {
          setState(() {
            userData = doc.data(); // Store user data in the state
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: userData == null
            ? const Center(
                child: CircularProgressIndicator()) // Show loader while data is being fetched
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: userData?['profileImageUrl'] != null
                        ? NetworkImage(userData!['profileImageUrl'])
                        : const AssetImage('assets/images/avator.png')
                            as ImageProvider,
                    radius: 40,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    userData?['name'] ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    userData?['email'] ?? 'No Email',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text('Home Number: '),
                      Text(userData?['homeNumber'] ?? 'No data'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text('Landmark: '),
                      Text(userData?['landmark'] ?? 'No data'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text('Lane: '),
                      Text(userData?['lane'] ?? 'No data'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text('Date of Birth: '),
                      Text(userData?['dob'] ?? 'No data'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text('Phone Number: '),
                      Text(userData?['phone'] ?? 'No data'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  UpdateProfileButton(),
                ],
              ),
      ),
    );
  }
}
