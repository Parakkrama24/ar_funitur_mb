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

  // Factory constructor to create an Item from Firestore document
  factory Item.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Item(
      name: data['name'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(), // Ensure price is a double
      image: data['image'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
    );
  }

  // Convert an Item object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'category': category,
    };
  }

  // Create an Item instance from a Map (generic function)
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
    );
  }
}
