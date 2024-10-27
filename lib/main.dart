import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kmwd/screens/Home.dart';
import 'package:kmwd/screens/authentcation/LoginScreen.dart';
import 'package:kmwd/screens/authentcation/Register.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
  await  Firebase.initializeApp(options: FirebaseOptions( apiKey: "AIzaSyBpYUp0fAU7tvxz4BfwWMvDnLz86Rfcoww",
  authDomain: "funitureapp-37893.firebaseapp.com",
  projectId: "funitureapp-37893",
  storageBucket: "funitureapp-37893.appspot.com",
  messagingSenderId: "981496557296",
  appId: "1:981496557296:web:e553cc872403bb249b1c35",
  measurementId: "G-SB0GSD6DR9"));
  }
 else{
   await Firebase.initializeApp();
 }

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
          child:Home()
        ),
      ),
      routes: <String,WidgetBuilder>{
        '/register': (context) => const Register(),
        '/login': (context)=>const Loginscreen(),
        '/home':(context)=>const Home()
      },
      //hghg
    );
  }
}
