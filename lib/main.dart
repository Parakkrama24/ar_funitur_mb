import 'package:flutter/material.dart';
import 'package:kmwd/screens/BillingPage.dart';
import 'package:kmwd/componnets/navBar/navbar.dart';
import 'package:kmwd/screens/shop.dart';
import 'package:kmwd/screens/userDataUpdate.dart';
import 'package:kmwd/screens/authentcation/LoginScreen.dart';
import 'package:kmwd/screens/authentcation/Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// Import the CartPage

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Loginscreen(),
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/register': (context) => const Register(),
        '/login': (context) => const Loginscreen(),
        '/home': (context) => const Shop(),
        '/checkout': (context) => const BillingPage(
              totalPrice: 100,
              deliveryCharge: 100,
              deliveryDate: 'gggg',
            ),
        '/updateProfile': (context) => const UpdateUserDetails(),
        '/navBar': (context) => const Navbar(),
      },
    );
  }
}
