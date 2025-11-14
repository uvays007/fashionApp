import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Upload extends StatelessWidget {
  const Upload({super.key});

  // -------------------- YOUR PRODUCT LIST --------------------
  final List<Map<String, String>> products = const [
    {
      "brandname": "2STROKE",
      "name": "Men Tshirt Black",
      "price": "RS 600",
      "image":
          "https://krixtqmafxrjqtvatpra.supabase.co/storage/v1/object/public/products/black_sale.png",
    },
    {
      "brandname": "Leventer",
      "name": "Men Jeans Blue",
      "price": "RS 1200",
      "image":
          "https://krixtqmafxrjqtvatpra.supabase.co/storage/v1/object/public/products/tuananh-blue-wNP79A-_bRY-unsplash.png",
    },
    {
      "brandname": "Ortox",
      "name": "Men Tshirt Blue",
      "price": "RS 500",
      "image":
          "https://krixtqmafxrjqtvatpra.supabase.co/storage/v1/object/public/products/blue_sale.png",
    },
    {
      "brandname": "Gladiator",
      "name": "Men Tshirt Green",
      "price": "RS 399",
      "image":
          "https://krixtqmafxrjqtvatpra.supabase.co/storage/v1/object/public/products/green_sale.png",
    },
  ];

  // -------------------- FIRESTORE UPLOAD FUNCTION --------------------
  Future<void> uploadProducts() async {
    for (var product in products) {
      await FirebaseFirestore.instance.collection("products").add({
        "brandname": product["brandname"],
        "name": product["name"],
        "price": product["price"],
        "image": product["image"],
      });
    }
    print("Upload complete!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            uploadProducts();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Products Uploaded!")));
          },
          child: const Text("Upload"),
        ),
      ),
    );
  }
}
