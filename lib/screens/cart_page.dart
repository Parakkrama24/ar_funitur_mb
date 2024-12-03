import 'package:flutter/material.dart';
import 'package:kmwd/models/Item.dart';
import 'package:kmwd/componnets/cart/CartItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kmwd/screens/BillingPage.dart'; // Import your checkout page

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartItem>> _cartItems;
  late Future<double> _totalPrice;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _cartItems = Cart.fetchItems();
    _totalPrice = Cart.getTotalPrice();
  }

  // Function to remove item from Firebase and local cart
  Future<void> _removeItemFromCart(CartItem cartItem, int index) async {
    // Remove item from Firebase
    try {
      // Assuming each CartItem has a unique 'id' stored in Firestore
      await _firestore.collection('cartItems').doc(cartItem.id).delete();

      // Remove item from local cart list
      setState(() {
        _cartItems = Cart.fetchItems(); // Refresh cart items
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${cartItem.item.name} removed from cart")),
      );
    } catch (e) {
      // Handle any errors that occur during Firebase deletion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error removing item: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<CartItem>>(
        future: _cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final cartItems = snapshot.data ?? [];

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return Dismissible(
                      key: Key(cartItem.item.name), // Ensure unique key
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        // Remove item from cart (both locally and Firebase)
                        _removeItemFromCart(cartItem, index);
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        leading: Image.network(cartItem.item.image,
                            width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(cartItem.item.name),
                        subtitle: Text("${cartItem.size} - ${cartItem.kit}"),
                        trailing: Text(
                            "\$${cartItem.item.price * cartItem.quantity}"),
                      ),
                    );
                  },
                ),
              ),
              FutureBuilder<double>(
                future: _totalPrice,
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
                    child: Text("Total: \$${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 20)),
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
                builder: (context) => BillingPage(
                    totalPrice: 122, // Update with actual value
                    deliveryCharge: 122, // Update with actual value
                    deliveryDate: "gdhd")), // Update with actual value
          );
        },
        child: const Icon(Icons.payment),
      ),
    );
  }
}
