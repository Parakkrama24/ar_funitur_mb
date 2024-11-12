import 'package:flutter/material.dart';
import 'package:kmwd/componnets/CartItemWidget/CartItemWidget.dart';
import 'package:kmwd/componnets/CartItemWidget/CheckoutButton.dart';
import 'package:kmwd/componnets/CartItemWidget/PromoCodeInput.dart';
import 'package:kmwd/componnets/CartItemWidget/TotalAmountSection.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bag", style: TextStyle(fontFamily: 'YourFontName', fontSize: 24)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                CartItemWidget(
                  name: 'Pullover',
                  color: 'Black',
                  size: 'L',
                  price: 51,
                  imageUrl: 'assets/images/pullover.png',
                ),
                CartItemWidget(
                  name: 'T-Shirt',
                  color: 'Gray',
                  size: 'L',
                  price: 30,
                  imageUrl: 'assets/images/tshirt.png',
                ),
                CartItemWidget(
                  name: 'Sport Dress',
                  color: 'Black',
                  size: 'M',
                  price: 43,
                  imageUrl: 'assets/images/sportdress.png',
                ),
              ],
            ),
          ),
          const PromoCodeInput(),
          const TotalAmountSection(totalAmount: 124),
          const CheckoutButton(),
        ],
      ),
    );
  }
}
