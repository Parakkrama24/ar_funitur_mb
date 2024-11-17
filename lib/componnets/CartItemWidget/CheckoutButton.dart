import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed("/checkout"); // Navigate to "/register"
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color.fromARGB(255, 235, 46, 29), // Checkout button color
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text('CHECK OUT',
            style: TextStyle(
                fontSize: 18, color: Color.fromARGB(251, 255, 255, 255))),
      ),
    );
  }
}
