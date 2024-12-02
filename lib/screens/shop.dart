import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kmwd/models/Item.dart';
import 'package:kmwd/componnets/common/ItemCard.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> with SingleTickerProviderStateMixin {
  late List<Item> items = [];
  late List<String> categories = [];
  late TabController _tabController;
  bool isLoading = true;
  String errorMessage = '';
  String searchQuery = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('items').get();
      setState(() {
        items = snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
        categories = [
          'All',
          ..._getCategories(items),
        ];
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
    return items.map((item) => item.category).toSet().toList();
  }

  List<Item> _filterItemsByCategory(String category) {
    if (category == 'All') return items;
    return items.where((item) => item.category == category).toList();
  }

  Future<List<Item>> _searchItems(String query) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('search_name', isGreaterThanOrEqualTo: query.toLowerCase())
          .where('search_name',
              isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
          .get();

      return snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to search items. Please try again later.';
      });
      return [];
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isNotEmpty) {
        final results = await _searchItems(query);
        setState(() {
          items = results;
        });
      } else {
        await _loadItems();
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
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
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search items...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                  _onSearchChanged(query);
                },
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : errorMessage.isNotEmpty
                      ? Center(
                          child: Text(
                            errorMessage,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          ),
                        )
                      : TabBarView(
                          controller: _tabController,
                          children: categories.map((category) {
                            final filteredItems =
                                _filterItemsByCategory(category);
                            return filteredItems.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No items found in this category.',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                : GridView.builder(
                                    padding: const EdgeInsets.all(16),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // Two items per row
                                      mainAxisSpacing: 12, // Vertical spacing
                                      crossAxisSpacing:
                                          12, // Horizontal spacing
                                      childAspectRatio:
                                          0.75, // Adjust for item card aspect ratio
                                    ),
                                    itemCount: filteredItems.length,
                                    itemBuilder: (context, index) {
                                      return ItemCard(
                                          item: filteredItems[index]);
                                    },
                                  );
                          }).toList(),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
