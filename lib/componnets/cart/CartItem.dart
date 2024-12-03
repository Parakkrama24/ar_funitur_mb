import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kmwd/models/Item.dart';

class Cart {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all cart items from Firestore
  static Future<List<CartItem>> fetchItems() async {
    try {
      final snapshot = await _firestore.collection('cart_items').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return CartItem(
          id: doc.id, // Use the document ID as the CartItem ID
          item: Item.fromMap(data['item']),
          size: data['size'],
          kit: data['kit'],
          quantity: data['quantity'],
        );
      }).toList();
    } catch (e) {
      print("Error fetching items: $e");
      return [];
    }
  }

  // Add item to Firestore
  static Future<void> addItem(
      Item item, String size, String kit, int quantity) async {
    try {
      await _firestore.collection('cart_items').add({
        'item': item.toMap(),
        'size': size,
        'kit': kit,
        'quantity': quantity,
      });
    } catch (e) {
      print("Error adding item to cart: $e");
    }
  }

  // Calculate total price by fetching cart items
  static Future<double> getTotalPrice() async {
    try {
      final snapshot = await _firestore.collection('cart_items').get();
      double total = 0;
      for (var doc in snapshot.docs) {
        var itemData = doc['item'];
        var price = itemData['price'];
        var quantity = doc['quantity'];
        total += price * quantity;
      }
      return total;
    } catch (e) {
      print("Error calculating total price: $e");
      return 0;
    }
  }
}




class CartItem {
  final String id;
  final Item item;
  final String size;
  final String kit;
  final int quantity;

  CartItem({
    required this.id,
    required this.item,
    required this.size,
    required this.kit,
    required this.quantity,
  });

  factory CartItem.fromFirestore(Map<String, dynamic> data, String docId) {
    return CartItem(
      id: docId,
      item: Item.fromMap(data['item']),
      size: data['size'],
      kit: data['kit'],
      quantity: data['quantity'],
    );
  }
}

