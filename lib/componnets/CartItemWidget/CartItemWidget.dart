import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final String name;
  final String color;
  final String size;
  final int price;
  final String imageUrl;

  const CartItemWidget({
    super.key,
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.asset(imageUrl, width: 50, height: 50, fit: BoxFit.cover), // Ensure images fit nicely
        title: Text(name),
        subtitle: Text('Color: $color, Size: $size'),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('\$$price'),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
                const Text('1'), // Quantity placeholder
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
