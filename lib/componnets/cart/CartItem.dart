import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kmwd/models/Item.dart';

class Cart {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all cart items from Firestore
  static Future<List<CartItem>> fetchItems() async {
    try {
      final snapshot = await _firestore.collection('cart_items').get();
      return snapshot.docs
          .map((doc) => CartItem.fromFirestore(doc.data()))
          .toList();
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
        'item': item
            .toMap(), // Assuming Item has a toMap() method to convert it to a Map
        'size': size,
        'kit': kit,
        'quantity': quantity,
      });
    } catch (e) {
      print("Error adding item to cart: $e");
    }
  }

  // Remove item from Firestore
  static Future<void> removeItem(String documentId) async {
    try {
      await _firestore.collection('cart_items').doc(documentId).delete();
    } catch (e) {
      print("Error removing item from cart: $e");
    }
  }

  // Calculate total price by fetching cart items
  static Future<double> getTotalPrice() async {
    try {
      final snapshot = await _firestore.collection('cart_items').get();
      double total = 0;
      for (var doc in snapshot.docs) {
        var itemData = doc['item'];
        var price =
            itemData['price']; // Assuming price is stored in the 'item' map
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

  // Convert CartItem from Firestore data
  factory CartItem.fromFirestore(Map<String, dynamic> data) {
    return CartItem(
      id: data['id'] ?? '',
      item: Item.fromMap(data[
          'item']), // Assuming Item has a fromMap() method to create an Item from a Map
      size: data['size'],
      kit: data['kit'],
      quantity: data['quantity'],
    );
  }
}
