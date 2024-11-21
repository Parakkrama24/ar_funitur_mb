import 'package:flutter/material.dart';
import 'package:kmwd/screens/Home.dart';
import 'package:kmwd/screens/UserDetails.dart';
import 'package:kmwd/screens/cartpage.dart';
import 'package:kmwd/screens/shop.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const Shop(),
    const CartPage(),
    const Userdetails()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(_selectedIndex)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Center(
            child: _screens[_selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 202, 29, 6),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          // Set background color to orange
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor:
              Colors.transparent, // Transparent to show the Container color
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color.fromARGB(255, 224, 55, 3),
          unselectedItemColor: Colors.black54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trolley),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'My Bag',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to set the AppBar title based on the selected index
  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'DecorIt';
      case 1:
        return 'Shop';
      case 2:
        return 'My Bag';
      case 3:
        return 'Messages';
      default:
        return '';
    }
  }
}
