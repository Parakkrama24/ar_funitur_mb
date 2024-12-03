import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'firebase_options.dart'; // This is the file generated during Firebase configuration

// Import necessary screens
import 'package:kmwd/screens/BillingPage.dart';
import 'package:kmwd/screens/shop.dart';
import 'package:kmwd/screens/userDataUpdate.dart';
import 'package:kmwd/screens/authentcation/LoginScreen.dart';
import 'package:kmwd/screens/authentcation/Register.dart';
import 'package:kmwd/screens/Nortification/NotificationsPage.dart';
import 'package:kmwd/screens/Nortification/OrderTrackingPage.dart';
import 'package:kmwd/componnets/navBar/navbar.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures that Firebase is initialized before the app starts

  // Initialize Firebase with the correct options for your platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Ensure this points to your Firebase configuration
  );

  runApp(const MyApp()); // Run the app after Firebase initialization
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4),
          child:
              NotificationsPage(), // Load the notifications page as the home page
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/register': (context) => const Register(),
        '/login': (context) => const Loginscreen(),
        '/home': (context) => const Shop(),
        '/checkout': (context) => const BillingPage(),
        '/updateProfile': (context) => const UpdateUserDetails(),
        '/navBar': (context) => const Navbar(),
        '/notifications': (context) => const NotificationsPage(),
        '/orderTracking': (context) => const OrderTrackingPage(
            orderId: 'order_12345'), // Pass the orderId dynamically
      },
    );
  }
}
