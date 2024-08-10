import 'package:flutter/material.dart';
import 'package:kmwd/styles/Style.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController NameController = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Sign up",
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
                controller: NameController,
                decoration: apptextDecoration.main(hinttext_: "Enter Name ..."),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: NameController,
                decoration: apptextDecoration.main(hinttext_: "Enter Name ..."),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: NameController,
                decoration: apptextDecoration.main(hinttext_: "Enter Name ..."),
              ),
               const SizedBox(
                height: 15,
              ),
              GestureDetector(child: Text("Already have an account? ->")),
              Container(
                height: 50,
                width: double.infinity,
                decoration: buttonDecoration.main(),
              )

            ],
          ),
        ),
      ),
    );
  }
}
