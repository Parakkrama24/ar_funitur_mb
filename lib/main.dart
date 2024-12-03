import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kmwd/screens/welcom.dart';
import 'firebase_options.dart';
import 'package:kmwd/screens/BillingPage.dart';
import 'package:kmwd/componnets/navBar/navbar.dart';
import 'package:kmwd/screens/authentcation/otherDetails.dart';
import 'package:kmwd/screens/shop.dart';
import 'package:kmwd/screens/userDataUpdate.dart';
import 'package:kmwd/screens/authentcation/LoginScreen.dart';
import 'package:kmwd/screens/authentcation/Register.dart';
import 'package:kmwd/screens/Nortification/NotificationsPage.dart';
import 'package:kmwd/screens/Nortification/OrderTrackingPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
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
          child: WelcomePage(),
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
        '/otherDetails': (context) => const OtherDetails(),
        '/notifications': (context) => const NotificationsPage(),
        '/orderTracking': (context) =>
            const OrderTrackingPage(orderId: 'order_12345'),
      },
    );
  }
}
