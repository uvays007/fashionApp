import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comercial_app/screens/AllProducts_screen/allproducts.dart';
import 'package:comercial_app/screens/product_screen/product.dart';
import 'package:comercial_app/services/wishlist_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  final VoidCallback? onGoToCart;
  const Home({super.key, required this.onGoToCart});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> allProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];
  List<bool> isLiked = [];

  final searchController = TextEditingController();

  int activeIndex = 0;
  final CarouselSliderController controller = CarouselSliderController();
  final wishlistService = WishlistService();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // ---------------- FETCH DATA FROM FIREBASE ----------------
  Future<void> _loadProducts() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("products")
        .get();

    final List<Map<String, dynamic>> firebaseProducts = snapshot.docs
        .map((doc) => doc.data())
        .toList();

    setState(() {
      allProducts = firebaseProducts;
      filteredProducts = List.from(allProducts);
      isLiked = List.generate(allProducts.length, (i) => false);
    });
  }

  // ---------------- SEARCH FUNCTION ----------------
  void searchProducts() {
    final query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() => filteredProducts = List.from(allProducts));
      return;
    }

    final matches = allProducts
        .where(
          (item) => item["brandname"].toString().toLowerCase().contains(query),
        )
        .toList();

    final nonmatches = allProducts
        .where(
          (item) => !item["brandname"].toString().toLowerCase().contains(query),
        )
        .toList();

    setState(() {
      filteredProducts = [...matches, ...nonmatches];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: allProducts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 7.h),

                    // ---------------- SEARCH BAR ----------------
                    Container(
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F3F4),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: TextFormField(
                        onChanged: (_) => searchProducts(),
                        controller: searchController,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: searchProducts,
                            child: Icon(Icons.search),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.h,
                            vertical: 10.h,
                          ),
                          border: InputBorder.none,
                          hintText: 'Search Products',
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // ---------------- ALL PRODUCTS GRID ----------------
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        print(product);
                        print("IMAGE => ${product['image']}");

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
                                            onGoToCart: widget.onGoToCart,
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        height: 205.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          child: Image.network(
                                            product['image']?.toString() ??
                                                "", // <-- SAFE
                                            height: 180.h,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    product['brandname'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    product['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  Text(
                                    product['price'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ---------------- ❤️ WISHLIST ----------------
                            Positioned(
                              right: 10,
                              top: 5,
                              child: StreamBuilder<bool>(
                                stream: wishlistService.isWishlisted(
                                  product['id'],
                                ),
                                builder: (context, snapshot) {
                                  final isLiked = snapshot.data ?? false;

                                  return GestureDetector(
                                    onTap: () {
                                      if (isLiked) {
                                        wishlistService.removeFromWishlist(
                                          product['id'],
                                        );
                                      } else {
                                        wishlistService.addToWishlist(product);
                                      }
                                    },
                                    child: AnimatedSwitcher(
                                      duration: Duration(milliseconds: 300),
                                      child: Icon(
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        key: ValueKey(isLiked),
                                        color: isLiked
                                            ? Colors.red
                                            : Colors.black,
                                        size: 28,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
