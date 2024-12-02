// cart.dart
import 'package:kmwd/models/Item.dart';

class Cart {
  static final List<CartItem> _items = [];

  static List<CartItem> get items => _items;

  static void addItem(Item item, String size, String kit, int quantity) {
    _items.add(CartItem(item: item, size: size, kit: kit, quantity: quantity));
  }

  static void removeItem(int index) {
    _items.removeAt(index);
  }

  static double get totalPrice {
    return _items.fold(
        0, (total, item) => total + (item.item.price * item.quantity));
  }
}

class CartItem {
  final Item item;
  final String size;
  final String kit;
  final int quantity;

  CartItem({
    required this.item,
    required this.size,
    required this.kit,
    required this.quantity,
  });
}
