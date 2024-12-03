import 'package:flutter/material.dart';
import 'package:kmwd/componnets/cart/CartItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kmwd/screens/BillingPage.dart'; // Import your checkout page

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CartItem>> _fetchCartItems() async {
    return Cart.fetchItems();
  }

  Future<double> _calculateTotalPrice() async {
    return Cart.getTotalPrice();
  }

  // Function to remove item from Firebase and refresh the cart
  Future<void> _removeItemFromCart(CartItem cartItem) async {
    try {
      await _firestore.collection('cart_items').doc(cartItem.id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${cartItem.item.name} removed from cart")),
      );
      setState(() {}); // Refresh the UI after removal
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error removing item: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<CartItem>>(
        future: _fetchCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final cartItems = snapshot.data ?? [];
          if (cartItems.isEmpty) {
            return const Center(
              child: Text(
                "Your cart is empty.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return Dismissible(
                      key: Key(cartItem.id), // Unique key for each item
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        _removeItemFromCart(cartItem);
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        leading: Image.network(
                          cartItem.item.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(cartItem.item.name),
                        subtitle: Text("${cartItem.size} - ${cartItem.kit}"),
                        trailing: Text(
                            "\$${(cartItem.item.price * cartItem.quantity).toStringAsFixed(2)}"),
                      ),
                    );
                  },
                ),
              ),
              FutureBuilder<double>(
                future: _calculateTotalPrice(),
                builder: (context, totalSnapshot) {
                  if (totalSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (totalSnapshot.hasError) {
                    return Text(
                        "Error calculating total: ${totalSnapshot.error}");
                  }
                  final totalPrice = totalSnapshot.data ?? 0.0;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Total: \$${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the checkout page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BillingPage(
                totalPrice: 122, // Replace with actual value
                deliveryCharge: 122, // Replace with actual value
                deliveryDate: "dd/MM/yyyy", // Replace with actual value
              ),
            ),
          );
        },
        child: const Icon(Icons.payment),
      ),
    );
  }
}
