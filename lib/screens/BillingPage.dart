import 'package:flutter/material.dart';
import 'package:kmwd/componnets/cart/CartItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BillingPage extends StatefulWidget {
  final double totalPrice;
  final double deliveryCharge;
  final String deliveryDate;

  const BillingPage({
    super.key,
    required this.totalPrice,
    required this.deliveryCharge,
    required this.deliveryDate,
  });

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each form field
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up resources
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    cardHolderNameController.dispose();
    super.dispose();
  }

  void _onProceed() async {
    if (_formKey.currentState?.validate() == true) {
      // Create a billing record
      final billingData = {
        'cardNumber': cardNumberController.text,
        'expiryDate': expiryDateController.text,
        'cvv': cvvController.text,
        'cardHolderName': cardHolderNameController.text,
        'timestamp':
            FieldValue.serverTimestamp(), // To store the time of submission
        'totalPrice': widget.totalPrice,
        'deliveryCharge': widget.deliveryCharge,
        'deliveryDate': widget.deliveryDate,
      };

      try {
        // Save to Firestore
        await FirebaseFirestore.instance.collection('billing').add(billingData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Billing details saved. Proceeding with payment...')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save billing details: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Billing Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 238, 63, 19),
                Color.fromARGB(255, 244, 51, 3)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display total cost, delivery charge, and delivery date
              Text(
                'Total Cost: \$${widget.totalPrice.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Delivery Charge: \$${widget.deliveryCharge.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                'Delivery Date: ${widget.deliveryDate}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Card Number
              TextFormField(
                controller: cardNumberController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  hintText: '1234 5678 9012 3456',
                  prefixIcon: const Icon(Icons.credit_card),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  } else if (value.length < 16) {
                    return 'Card number must be 16 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Expiry Date
              TextFormField(
                controller: expiryDateController,
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  hintText: 'MM/YY',
                  prefixIcon: const Icon(Icons.calendar_today),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // CVV
              TextFormField(
                controller: cvvController,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  hintText: '123',
                  prefixIcon: const Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  } else if (value.length != 3) {
                    return 'CVV must be 3 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Cardholder Name
              TextFormField(
                controller: cardHolderNameController,
                decoration: InputDecoration(
                  labelText: 'Cardholder Name',
                  hintText: 'John Doe',
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cardholder name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Proceed Button
              Center(
                child: ElevatedButton(
                  onPressed: _onProceed,
                  child: const Text('Proceed'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
