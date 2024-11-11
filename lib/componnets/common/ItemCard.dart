import 'package:flutter/material.dart';
import 'package:kmwd/models/Item.dart';
import 'package:kmwd/screens/Item_Screen.dart';

class Itemcard extends StatelessWidget {
  final Item item;
  const Itemcard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      width: double.infinity,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to item detail page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailPage(item: item),
                    ),
                  );
                },
                child: Image.asset(
                  item.image,
                  width: 150,
                  height: 150, // Set the height you want
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text('\$${item.price}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
