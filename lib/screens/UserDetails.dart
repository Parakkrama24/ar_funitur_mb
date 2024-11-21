import "package:flutter/material.dart";

class Userdetails extends StatefulWidget {
  const Userdetails({super.key});

  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/avator.png'),
              radius: 40,
            ),
            SizedBox(
              height: 16,
            ),
            Text("Nimal Lakshan")
          ],
        ),
      ),
    );
  }
}
