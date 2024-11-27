import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      // Replace 'users' and 'userId' with your actual collection name and document ID
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc('userId')
          .get();

      if (doc.exists) {
        setState(() {
          userData = doc.data(); // Store user data in the state
        });
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
                child:
                    CircularProgressIndicator()) // Show loader while data is being fetched
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
                      const Icon(Icons.phone),
                      const SizedBox(width: 8.0),
                      Text(userData?['phone'] ?? 'No Phone'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 8.0),
                      Text(userData?['dob'] ?? 'No DOB'),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () =>
                        {}, // Add functionality to update data here
                    child: const Text('Update Profile'),
                  ),
                ],
              ),
      ),
    );
  }
}

 //example data base
 

// {
//   "name": "Sam Smith",
//   "email": "samsmith@mail.com",
//   "phone": "+1 987 654 3210",
//   "dob": "23rd Dec, 1990",
//   "profileImageUrl": "https://example.com/path-to-profile-image.jpg"
// }
