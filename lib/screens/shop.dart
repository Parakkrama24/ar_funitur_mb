import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading assets
import 'package:kmwd/models/Item.dart';
import 'package:kmwd/componnets/common/ItemCard.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late List<Item> items = [];

  @override
  void initState() {
    super.initState();
    // Load JSON data when the widget initializes
    _loadItems();
  }

  // Function to load JSON data
  Future<void> _loadItems() async {
    final String response = await rootBundle.loadString('assets/items.json');
    final List<dynamic> data = json.decode(response);

    // Convert the JSON data into a list of Item objects
    setState(() {
      items = data.map((item) => Item.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: SafeArea(
        child: items.isEmpty
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show a loader until data is loaded
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Itemcard(
                      item: items[index]); // Display each item using Itemcard
                },
              ),
      ),
    );
  }
}
