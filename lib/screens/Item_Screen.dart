import 'package:flutter/material.dart';
import 'package:kmwd/models/Item.dart';
import 'package:kmwd/componnets/cart/CartItem.dart';
import 'cart_page.dart';

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

  void addToCart() {
    Cart.addItem(widget.item, selectedSize, selectedKit, quantity);

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${widget.item.name} added to cart!"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FIFA World Cup Kits"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
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
                  // Image with shadow
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.network(widget.item.image, height: 200),
                  ),
                  const SizedBox(height: 16),
                  // Item Name
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Text("NIKE",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 8),
                  // Item Price
                  Text('\$${widget.item.price}',
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Size Selection
            const Text("Size",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 12,
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
            const Text("Kit",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 12,
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
            const Text("Qty",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
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
                Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
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
                  onPressed: addToCart,
                  child: const Text("Add to Cart"),
                  style: ElevatedButton.styleFrom(
                    elevation: 5, // Adding shadow
                    shadowColor: Colors.black.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Checkout"),
                  style: ElevatedButton.styleFrom(
                    elevation: 5, // Adding shadow
                    shadowColor: Colors.black.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
