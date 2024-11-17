class Item {
  final String name;
  final String price;
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

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        name: json['name'],
        price: json['price'],
        image: json['image'],
        description: json['Description'],
        category: json['Description']);
  }
}
