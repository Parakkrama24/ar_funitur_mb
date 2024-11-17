import 'package:flutter/material.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

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

  void _onProceed() {
    if (_formKey.currentState?.validate() == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proceeding with payment...')),
      );
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
              const Spacer(),

              // Proceed Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onProceed,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Proceed',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
