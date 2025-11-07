import 'package:comercial_app/screens/order_screen/orderpayment.dart';
import 'package:flutter/material.dart';
import 'package:comercial_app/theme/Textstyles.dart';
import 'package:comercial_app/screens/global_screen/global.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _calculateTotal() {
    double sum = 0.0;
    for (var cart in carts) {
      final priceString = cart['price'].toString().replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );
      sum += double.tryParse(priceString) ?? 0;
    }
    setState(() => totalPrice = sum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: carts.isEmpty
          ? null
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
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
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderPaymentPage(
                        total: totalPrice.toStringAsFixed(2),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),

      body: carts.isEmpty
          ? const Center(child: Text("Your Cart is Empty"))
          : SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ITEMS',
                            style: AppTextStyles.semiBold.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'DESCRIPTION',
                            style: AppTextStyles.semiBold.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'PRICE',
                            style: AppTextStyles.semiBold.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: carts.length,
                        itemBuilder: (context, index) {
                          final cart = carts[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  cart['image'],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 65),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cart['brandname'],
                                        style: AppTextStyles.semiBold,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        cart['name'],
                                        style: AppTextStyles.medium,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  cart['price'],
                                  style: AppTextStyles.bold.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Shipping Address",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        maxLines: 3,
                        keyboardType: TextInputType.streetAddress,

                        decoration: InputDecoration(
                          hintText: "Enter your full shipping address",
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Coupon Code",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: "Apply coupon code",
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                          suffixIcon: IconButton(
                            icon: const Icon(Icons.check_circle_outline),
                            color: const Color(0xFFC19375),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Coupon applied successfully"),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Rs.${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Shipping',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Free',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 1.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rs.${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
