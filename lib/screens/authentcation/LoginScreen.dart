import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kmwd/styles/Style.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void loginUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Navigate to the Home page if login is successful
      Navigator.of(context).pushReplacementNamed('/navBar');
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 206, 202, 201),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/back.jpg"), // Replace with your image path
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
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: apptextDecoration.main(
                    hinttext_: "Enter Email...",
                    labaleText: "Email",
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: apptextDecoration.main(
                    hinttext_: "Enter Password...",
                    labaleText: "Password",
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  child: const Text("Don’t have an account?"),
                  onTap: () {
                    Navigator.of(context).pushNamed('/otherDetails');
                  },
                ),
                const SizedBox(height: 15),
                isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: loginUser,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: buttonDecoration.main(color_: Colors.red),
                          child: const Center(
                            child: Text(
                              "Sign In",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
