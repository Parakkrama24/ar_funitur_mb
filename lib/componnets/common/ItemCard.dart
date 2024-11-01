import 'package:flutter/material.dart';
import 'package:kmwd/models/Item.dart';

class Itemcard extends StatelessWidget {
  final Item item;
  const Itemcard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ListTile(
        leading: Image.asset(
          item.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        subtitle: Text('\$${item.price}'),
      ),
    );
  }
}
