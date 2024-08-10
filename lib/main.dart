import 'package:flutter/material.dart';
import 'package:kmwd/screens/Home.dart';
import 'package:kmwd/screens/Register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Register()
        ),
      ),
    );
  }
}
