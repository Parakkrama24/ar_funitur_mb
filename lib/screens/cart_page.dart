import 'package:flutter/material.dart';
import 'package:kmwd/componnets/cart/CartItem.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: Cart.items.length,
        itemBuilder: (context, index) {
          final cartItem = Cart.items[index];
          return ListTile(
            leading: Image.network(cartItem.item.image, width: 50),
            title: Text(cartItem.item.name),
            subtitle: Text(
                "Size: ${cartItem.size}, Kit: ${cartItem.kit}, Qty: ${cartItem.quantity}"),
            trailing: Text("\$${cartItem.item.price * cartItem.quantity}"),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Total: \$${Cart.totalPrice.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }
}
