import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comercial_app/screens/product_screen/product.dart';
import 'package:comercial_app/theme/Textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Allproducts extends StatelessWidget {
  final VoidCallback? onGoToCart;
  const Allproducts({super.key, required this.onGoToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "All Products",
          style: AppTextStyles.semiBold.copyWith(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFC19375),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            SizedBox(height: 15.h),

            // ---------------------- STREAM BUILDER ----------------------
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No products available"));
                  }

                  // Convert products
                  final List<Map<String, dynamic>> products = snapshot
                      .data!
                      .docs
                      .map((doc) {
                        return doc.data() as Map<String, dynamic>;
                      })
                      .toList();

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Product(
                                          product: product,
                                          onGoToCart: onGoToCart,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      height: 205.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(15),
                                      ),

                                      // NETWORK IMAGE
                                      child: Image.network(
                                        product["image"],
                                        height: 180.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                Text(
                                  product["brandname"] ?? "",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),

                                Text(
                                  product["name"] ?? "",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                  ),
                                ),

                                Text(
                                  product["price"] ?? "",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
