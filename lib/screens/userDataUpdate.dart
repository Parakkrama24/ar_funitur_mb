import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUserDetails extends StatefulWidget {
  const UpdateUserDetails({super.key});

  @override
  State<UpdateUserDetails> createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for user details
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _homeNumberController = TextEditingController();
  final TextEditingController _laneController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _townController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Replace 'users' and 'userId' with your collection name and document ID
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc('userId')
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          setState(() {
            _nameController.text = data['name'] ?? '';
            _phoneController.text = data['phone'] ?? '';
            _homeNumberController.text = data['homeNumber'] ?? '';
            _laneController.text = data['lane'] ?? '';
            _landmarkController.text = data['landmark'] ?? '';
            _townController.text = data['town'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> updateUserData() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Replace 'users' and 'userId' with your collection name and document ID
        await FirebaseFirestore.instance
            .collection('users')
            .doc('userId')
            .update({
          'name': _nameController.text,
          'phone': _phoneController.text,
          'homeNumber': _homeNumberController.text,
          'lane': _laneController.text,
          'landmark': _landmarkController.text,
          'town': _townController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEEEF), // Light pink background
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                buildTextFormField(
                    _nameController, 'Name', 'Please enter your name'),
                const SizedBox(height: 16.0),
                buildTextFormField(
                  _phoneController,
                  'Phone Number',
                  'Please enter your phone number',
                ),
                const SizedBox(height: 16.0),
                buildTextFormField(_homeNumberController, 'Home Number'),
                const SizedBox(height: 16.0),
                buildTextFormField(_laneController, 'Lane'),
                const SizedBox(height: 16.0),
                buildTextFormField(_landmarkController, 'Landmark'),
                const SizedBox(height: 16.0),
                buildTextFormField(
                    _townController, 'Town', 'Please enter your town'),
                const SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton(
                    onPressed: updateUserData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Bold red button
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Update Profile',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(
    TextEditingController controller,
    String label, [
    String? validationMessage,
    TextInputType keyboardType = TextInputType.text,
  ]) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      validator: validationMessage != null
          ? (value) => value == null || value.isEmpty ? validationMessage : null
          : null,
    );
  }
}
