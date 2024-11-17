import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kmwd/models/Item.dart';
import 'package:kmwd/componnets/common/ItemCard.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> with SingleTickerProviderStateMixin {
  late List<Item> items = [];
  late List<String> categories = []; // Store unique categories
  late TabController _tabController; // For tab navigation
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final String response = await rootBundle.loadString('assets/item.json');
      final List<dynamic> data = json.decode(response);

      setState(() {
        items = data.map((item) => Item.fromJson(item)).toList();
        categories = [
          'All',
          ..._getCategories(items)
        ]; // Add "All" to the categories
        _tabController = TabController(length: categories.length, vsync: this);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load items. Please try again later.';
        isLoading = false;
      });
    }
  }

  List<String> _getCategories(List<Item> items) {
    // Extract unique categories from items
    return items.map((item) => item.category).toSet().toList();
  }

  List<Item> _filterItemsByCategory(String category) {
    if (category == 'All') return items;
    return items.where((item) => item.category == category).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        bottom: isLoading || errorMessage.isNotEmpty
            ? null
            : TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: categories.map((category) {
                  return Tab(
                    text: category,
                  );
                }).toList(),
              ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  )
                : TabBarView(
                    controller: _tabController,
                    children: categories.map((category) {
                      final filteredItems = _filterItemsByCategory(category);

                      return filteredItems.isEmpty
                          ? const Center(
                              child: Text(
                                'No items found in this category.',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Itemcard(
                                    item: filteredItems[index],
                                  ),
                                );
                              },
                            );
                    }).toList(),
                  ),
      ),
    );
  }
}
