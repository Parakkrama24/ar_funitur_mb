class Item {
  final String name;
  final String price;
  final String image;
  Item({required this.name, required this.price, required this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(name: json['name'], price: json['price'], image: json['image']);
  }
}
