import 'package:comercial_app/screens/order_screen/orderpayment.dart';
import 'package:comercial_app/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:comercial_app/theme/Textstyles.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final cartslist = CartlistService();

  double calculateTotal(List<Map<String, dynamic>> carts) {
    double sum = 0;

    for (var cart in carts) {
      final priceString = cart['price'].toString().replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );

      double price = double.tryParse(priceString) ?? 0;
      int qty = cart['qty'] ?? 1;

      sum += price * qty;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F3),

      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: cartslist.getCartlist(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final carts = snapshot.data!;
          final totalPrice = calculateTotal(carts);

          if (carts.isEmpty) {
            return const Center(
              child: Text(
                "Your Cart is Empty",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: carts.length,
                      separatorBuilder: (_, __) => SizedBox(height: 5),
                      itemBuilder: (context, index) {
                        final cart = carts[index];

                        final priceString = cart['price'].toString().replaceAll(
                          RegExp(r'[^0-9.]'),
                          '',
                        );

                        double basePrice = double.tryParse(priceString) ?? 0;
                        int qty = cart['qty'] ?? 1;

                        double itemTotal = basePrice * qty;

                        return Container(
                          height: 125,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  cart['image'],
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cart['brandname'],
                                    style: AppTextStyles.bold.copyWith(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    cart['name'],
                                    style: AppTextStyles.medium.copyWith(
                                      color: Colors.grey[700],
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  SizedBox(
                                    width: 70,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        value: qty,
                                        isExpanded: true,
                                        items: List.generate(
                                          10,
                                          (i) => DropdownMenuItem(
                                            value: i + 1,
                                            child: Text(
                                              '${i + 1}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          cartslist.addToCart({
                                            ...cart,
                                            "qty": value!,
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Spacer(),

                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rs.${itemTotal.toStringAsFixed(2)}",
                                    style: AppTextStyles.bold.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () =>
                                        cartslist.removeFromCart(cart['id']),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Remove',
                                            style: AppTextStyles.bold,
                                          ),
                                          Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 22,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _totalRow(
                            "Subtotal",
                            "Rs.${totalPrice.toStringAsFixed(2)}",
                          ),
                          const SizedBox(height: 6),
                          _totalRow(
                            "Shipping",
                            "Free",
                            valueColor: Colors.green,
                          ),
                          const Divider(height: 25, thickness: 1),
                          _totalRow(
                            "Total",
                            "Rs.${totalPrice.toStringAsFixed(2)}",
                            isBold: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: StreamBuilder<List<Map<String, dynamic>>>(
        stream: cartslist.getCartlist(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) return SizedBox();

          final totalPrice = calculateTotal(snapshot.data!);

          return Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Rs.${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC19375),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderPaymentPage(
                            total: totalPrice.toStringAsFixed(2),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Place Order",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _totalRow(
    String title,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isBold ? 17 : 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 17 : 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
