import 'package:comercial_app/screens/global_screen/global.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  final Map<String, String> product;

  const Product({super.key, required this.product});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  String selectedSize = 'M';
  Color selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC19375),
        foregroundColor: Colors.white,
      ),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          widget.product['image']!,
                          height: 360,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product['name'] ?? 'Product Name',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          '₹${widget.product['price'] ?? '0'}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.product['category'] ?? 'Men T-shirt',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontFamily: 'Inter',
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Select Size',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) {
                        final bool isSelected = selectedSize == size;
                        double sizepadding;
                        if (size == 'XL') {
                          sizepadding = 15;
                        } else if (size == 'XXL') {
                          sizepadding = 10;
                        } else {
                          sizepadding = 20;
                        }
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(
                              horizontal: sizepadding,

                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Colors.red
                                    : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected ? Colors.red : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Select Color',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _colorDot(Colors.black),
                        _colorDot(Colors.blue),
                        _colorDot(Colors.red),
                        _colorDot(Colors.green),
                        _colorDot(Colors.orange),
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product['description'] ??
                          'Stay comfortable all day with our 100% premium cotton t-shirt. '
                              'Designed with a slim fit and breathable fabric, perfect for daily wear. '
                              'Pair it with jeans, joggers, or shorts for a stylish casual look.',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC19375),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            minimumSize: const Size(double.infinity, 56),
          ),
          onPressed: () {
            if (selectedSize == null || selectedColor == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Please select size and color'),
                ),
              );
              return;
            }

            carts.add({
              'name': widget.product['name'],
              'price': widget.product['price'],
              'image': widget.product['image'],
              'brandname': widget.product['brandname'],
            });

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Added to cart!')));
          },
          child: const Text(
            'Add to Cart',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _colorDot(Color color) {
    final bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? Color.fromARGB(255, 149, 101, 69)
                : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
        ),
      ),
    );
  }
}
