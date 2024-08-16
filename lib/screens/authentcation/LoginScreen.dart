import 'package:flutter/material.dart';
import 'package:kmwd/styles/Style.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextField(
                        controller: EmailController,
                        decoration:
                            apptextDecoration.main(hinttext_: "Enter Email..." ,labaleText: "Email"),
                        
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: PasswordController,
                        obscureText: true,
                        decoration:
                            apptextDecoration.main(hinttext_: "Enter Password..." ,labaleText: "Password"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
        ));
  }
}
