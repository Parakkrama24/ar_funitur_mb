import 'package:flutter/material.dart';
import 'package:kmwd/componnets/navBar/navbar.dart';
import 'package:kmwd/screens/shop.dart';
import 'package:kmwd/screens/authentcation/LoginScreen.dart';
import 'package:kmwd/screens/authentcation/Register.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
          child:Navbar()
        ),
      ),
      routes: <String,WidgetBuilder>{
        '/register': (context) => const Register(),
        '/login': (context)=>const Loginscreen(),
        '/home':(context)=>const Shop()
      },
      //hghg
    );
  }
}
