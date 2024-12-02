import 'package:flutter/material.dart';
import 'package:kmwd/styles/Style.dart';
import 'package:kmwd/Database/auth_service.dart'; // Import the AuthService

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? errorMessage;

  void _registerUser() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    String? result = await _authService.registerUser(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      homeNumber: '',
      landmark: '',
      lane: '',
      dob: '',
      phone: '',
    );

    setState(() {
      isLoading = false;
    });

    // Display error message
    setState(() {
      errorMessage = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(fontSize: 40),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: apptextDecoration.main(hinttext_: "Enter Name ..."),
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
                decoration:
                    apptextDecoration.main(hinttext_: "Enter Password ..."),
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
                          child: CircularProgressIndicator(color: Colors.white))
                      : const Center(
                          child: Text(
                            "Sign up",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
