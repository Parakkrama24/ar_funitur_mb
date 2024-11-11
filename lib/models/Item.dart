class Item {
  final String name;
  final String price;
  final String image;
  final String description;
  Item(
      {required this.name,
      required this.price,
      required this.image,
      required this.description});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        name: json['name'],
        price: json['price'],
        image: json['image'],
        description: json['Description']);
  }
}
