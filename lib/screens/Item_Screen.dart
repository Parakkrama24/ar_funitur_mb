import 'package:flutter/material.dart';
import 'package:kmwd/models/Item.dart';

class ItemDetailPage extends StatefulWidget {
  final Item item;
  const ItemDetailPage({super.key, required this.item});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  String selectedSize = "M"; // Default selected size
  String selectedKit = "HOME"; // Default selected kit
  int quantity = 1; // Default quantity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FIFA World Cup Kits"),
        actions: [
          IconButton(
            onPressed: () {
              // Open Cart Action
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.network(
                    widget.item.image,
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "NIKE",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${widget.item.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Size Selection
            const Text(
              "Size",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["S", "M", "L", "XL", "XXL"]
                  .map((size) => ChoiceChip(
                        label: Text(size),
                        selected: selectedSize == size,
                        onSelected: (selected) {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            // Kit Selection
            const Text(
              "Kit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["HOME", "AWAY", "THIRD"]
                  .map((kit) => ChoiceChip(
                        label: Text(kit),
                        selected: selectedKit == kit,
                        onSelected: (selected) {
                          setState(() {
                            selectedKit = kit;
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            // Quantity Selector
            const Text(
              "Qty",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add to cart action
                  },
                  child: const Text("Add to Cart"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Checkout action
                  },
                  child: const Text("Checkout"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
