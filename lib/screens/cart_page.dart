import 'package:flutter/material.dart';
import 'package:kmwd/componnets/cart/CartItem.dart';
import 'package:kmwd/screens/BillingPage.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView.builder(
          itemCount: Cart.items.length,
          itemBuilder: (context, index) {
            final cartItem = Cart.items[index];
            return Dismissible(
              key: Key(cartItem.item.name),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                // Handle item removal
                Cart.items.removeAt(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('${cartItem.item.name} removed from the cart')),
                );
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Image.network(cartItem.item.image,
                      width: 60, height: 60, fit: BoxFit.cover),
                  title: Text(
                    cartItem.item.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Size: ${cartItem.size}, Kit: ${cartItem.kit}, Qty: ${cartItem.quantity}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  trailing: Text(
                    "\$${(cartItem.item.price * cartItem.quantity).toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: \$${Cart.totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BillingPage(
                      totalPrice: Cart.totalPrice,
                      deliveryCharge: 5.0, // Assume a fixed delivery charge
                      deliveryDate: "2024-12-15", // Example delivery date
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Checkout",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
