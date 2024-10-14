import 'package:flutter/material.dart';
import 'package:kmwd/screens/Home.dart';
import 'package:kmwd/screens/authentcation/LoginScreen.dart';
import 'package:kmwd/screens/authentcation/Register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4),
          child:const Home()
        ),
      ),
      routes: <String,WidgetBuilder>{
        '/register': (context) => Register(),
        '/login': (context)=>Loginscreen(),
        '/home':(context)=>Home()
      },
      //hghg
    );
  }
}
