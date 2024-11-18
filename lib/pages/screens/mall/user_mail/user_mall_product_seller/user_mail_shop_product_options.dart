import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionalProductCreationPage extends StatefulWidget {
  const OptionalProductCreationPage({super.key});

  @override
  State<OptionalProductCreationPage> createState() =>
      _OptionalProductCreationPageState();
}

class _OptionalProductCreationPageState
    extends State<OptionalProductCreationPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo sản phẩm tùy chọn'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Return to previous page
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Add your optional product fields here
              // Example:
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tên tùy chọn',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the data and return to previous page
                    Navigator.pop(context, {
                      // Return your data here
                      'optionalProductData': 'Your data here'
                    });
                  }
                },
                child: const Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
