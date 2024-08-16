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
          title: const Text(
            "Login",
            style: TextStyle(fontSize: 40),
          ),
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
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: EmailController,
                        decoration: apptextDecoration.main(
                            hinttext_: "Enter Email...", labaleText: "Email"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: PasswordController,
                        obscureText: true,
                        decoration: apptextDecoration.main(
                            hinttext_: "Enter Password...",
                            labaleText: "Password"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        child: const Text("Do you a haven't account"),
                        onTap: () =>
                            {Navigator.of(context).pushNamed("/register")},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: buttonDecoration.secondary(),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forgot Password",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: buttonDecoration.main(color_: Colors.red),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
        ));
  }
}
