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
        title: const Text("Wishlist"),
        backgroundColor: const Color(0xFFC19375),
      ),

      body: wishlistItems.isEmpty
          ? const Center(child: Text("Your wishlist is empty"))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                final originalIndex = item["index"] ?? -1;

                return _buildWishlistItem(item, originalIndex);
              },
            ),
    );
  }

  Widget _buildWishlistItem(Map<String, dynamic> p, int originalIndex) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              safe(p['image']),
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // TEXT + BUTTONS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  safe(p['name']),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 5),

                Text(
                  safe(p['price']),
                  style: const TextStyle(
                    color: Color(0xFFC19375),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        carts.add(p);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${p['name']} added to cart")),
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

                    const SizedBox(width: 20),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          wishlistItems.removeWhere(
                            (item) => (item['index'] ?? -1) == originalIndex,
                          );

                          if (originalIndex >= 0 &&
                              originalIndex < isLiked.length) {
                            isLiked[originalIndex] = false;
                          }
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
