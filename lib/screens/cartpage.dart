import 'package:flutter/material.dart';
import 'package:kmwd/componnets/CartItemWidget/CartItemWidget.dart';
import 'package:kmwd/componnets/CartItemWidget/CheckoutButton.dart';
import 'package:kmwd/componnets/CartItemWidget/PromoCodeInput.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // List to store cart items
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Pullover',
      'color': 'Black',
      'size': 'L',
      'price': 51.0,
      'imageUrl': 'assets/images/pullover.png',
      'quantity': 1,
    },
    {
      'name': 'T-Shirt',
      'color': 'Gray',
      'size': 'L',
      'price': 30.0,
      'imageUrl': 'assets/images/tshirt.png',
      'quantity': 1,
    },
    {
      'name': 'Sport Dress',
      'color': 'Black',
      'size': 'M',
      'price': 43.0,
      'imageUrl': 'assets/images/sportdress.png',
      'quantity': 1,
    },
  ];

  // Function to calculate total amount
  double get totalAmount {
    return _cartItems.fold(
        0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  // Function to update the quantity of a cart item
  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      _cartItems[index]['quantity'] = newQuantity;
    });
  }

  // Function to remove an item from the cart
  void _removeItem(int index) {
    setState(() {
      final removedItem = _cartItems.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${removedItem['name']} removed from the cart.'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Bag",
          style: TextStyle(fontFamily: 'YourFontName', fontSize: 24),
        ),
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
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return Dismissible(
                  key: Key(item['name']),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) => _removeItem(index),
                  child: Column(
                    children: [
                      CartItemWidget(
                        name: item['name'],
                        color: item['color'],
                        size: item['size'],
                        price: item['price'],
                        imageUrl: item['imageUrl'],
                        quantity: item['quantity'],
                        onQuantityChanged: (newQuantity) =>
                            _updateQuantity(index, newQuantity),
                      ),
                      const Divider(), // Adds a divider between items
                    ],
                  ),
                );
              },
            ),
          ),
          const PromoCodeInput(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const CheckoutButton(),
        ],
      ),
    );
  }
}
