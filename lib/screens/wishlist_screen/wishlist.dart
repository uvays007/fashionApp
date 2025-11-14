import 'package:flutter/material.dart';
import 'package:comercial_app/screens/global_screen/global.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          'Wishlist',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFC19375),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: wishlistItems.isEmpty
          ? const Center(
              child: Text(
                "Your wishlist is empty",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                final originalIndex = item['index'];

                return _buildWishlistItem(item, originalIndex);
              },
            ),
    );
  }

  Widget _buildWishlistItem(Map<String, dynamic> product, int originalIndex) {
    final img = product['image'];
    final bool isNetwork = img.toString().startsWith("http");

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // PRODUCT IMAGE
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: isNetwork
                    ? NetworkImage(img)
                    : AssetImage(img) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // TEXT + BUTTONS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  product['price'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFC19375),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    // ADD TO CART
                    ElevatedButton(
                      onPressed: () {
                        carts.add(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${product['name']} added to cart"),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC19375),
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const SizedBox(width: 25),

                    // REMOVE FROM WISHLIST
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          wishlistItems.removeWhere(
                            (item) => item['index'] == originalIndex,
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC19375),
                      ),
                      child: const Text(
                        "Remove",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
