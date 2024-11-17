import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final String name;
  final String color;
  final String size;
  final double price;
  final String imageUrl;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const CartItemWidget({
    super.key,
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Color: $color',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Size: $size',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            // Quantity Controller
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    onQuantityChanged(quantity + 1);
                  },
                  color: Colors.blue,
                ),
                Text(
                  '$quantity',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (quantity > 1) {
                      onQuantityChanged(quantity - 1);
                    }
                  },
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
