import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String name;
  final double price;
  final String image;
  final String description;
  final String category;

  Item({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
  });

  factory Item.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Item(
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      image: data['image'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
    );
  }
}
