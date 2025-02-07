import 'package:flutter/material.dart';
import 'package:kmwd/styles/Style.dart';
import 'package:kmwd/Database/auth_service.dart'; // Import the AuthService
// Import Firestore

class OtherDetails extends StatefulWidget {
  const OtherDetails({super.key});

  @override
  State<OtherDetails> createState() => _RegisterState();
}

class _RegisterState extends State<OtherDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController laneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? errorMessage;

  void _registerUser() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // Capture user details
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String homeNumber = homeNumberController.text.trim();
    String landmark = landmarkController.text.trim();
    String lane = laneController.text.trim();
    String dob = dobController.text.trim();
    String phone = phoneController.text.trim();

    // Call AuthService to register the user with all details
    String? result = await _authService.registerUser(
      name: name,
      email: email,
      password: password,
      homeNumber: homeNumber,
      landmark: landmark,
      lane: lane,
      dob: dob,
      phone: phone,
    );

    setState(() {
      isLoading = false;
    });

    // Display error message
    setState(() {
      errorMessage = result;
    });
    // If registration is successful, navigate to login
    if (result == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Details",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/wallArt.jpg', // Replace with your image path
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Semi-transparent overlay
          Container(
            color: Colors.white.withOpacity(0.5),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration:
                          apptextDecoration.main(hinttext_: "Enter Name ..."),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration:
                          apptextDecoration.main(hinttext_: "Enter Email ..."),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: apptextDecoration.main(
                          hinttext_: "Enter Password ..."),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: homeNumberController,
                      decoration: apptextDecoration.main(
                          hinttext_: "Enter Home Number ..."),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: landmarkController,
                      decoration: apptextDecoration.main(
                          hinttext_: "Enter Landmark ..."),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: laneController,
                      decoration:
                          apptextDecoration.main(hinttext_: "Enter Lane ..."),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: dobController,
                      decoration: apptextDecoration.main(
                          hinttext_: "Enter DOB (e.g. 23rd Dec, 1990) ..."),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneController,
                      decoration: apptextDecoration.main(
                          hinttext_: "Enter Phone Number ..."),
                    ),
                    const SizedBox(height: 15),
                    if (errorMessage != null)
                      Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      child: const Text("Already have an account?"),
                      onTap: () => {Navigator.of(context).pushNamed('/login')},
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: _registerUser,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: buttonDecoration.main(color_: Colors.red),
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white))
                            : const Center(
                                child: Text(
                                  "Complete",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
