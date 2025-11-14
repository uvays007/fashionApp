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

  // -------------------- TOTAL CALCULATION -----------------------
  void _calculateTotal() {
    double sum = 0.0;

    for (var cart in carts) {
      final priceString = cart['price'].toString().replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );

      double price = double.tryParse(priceString) ?? 0;
      int qty = cart['qty'] ?? 1;

      sum += price * qty;
    }

    setState(() => totalPrice = sum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F3),

      // ---------------- Bottom Button ----------------
      bottomNavigationBar: carts.isEmpty
          ? null
          : Container(
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
                  Center(
                    child: Text(
                      "Rs.${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
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
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPaymentPage(
                              total: totalPrice.toStringAsFixed(2),
                            ),
                          ),
                        );

                        if (result == true) {
                          setState(() => carts.clear());
                        }
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
            ),

      // ---------------- Main Body ----------------
      body: carts.isEmpty
          ? const Center(
              child: Text(
                "Your Cart is Empty",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: carts.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 5),
                        itemBuilder: (context, index) {
                          final cart = carts[index];

                          // Extract base price number
                          final priceString = cart['price']
                              .toString()
                              .replaceAll(RegExp(r'[^0-9.]'), '');

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
                                  child: Image.asset(
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

                                    // --------- QTY DROPDOWN ----------
                                    SizedBox(
                                      width: 70,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: qty,
                                          isExpanded: true,
                                          icon: Icon(Icons.arrow_drop_down),
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
                                            setState(() {
                                              cart['qty'] = value!;
                                              _calculateTotal();
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
                                    // ---------- DELETE BUTTON ----------
                                    SizedBox(
                                      height: 40,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            carts.removeAt(index);
                                            _calculateTotal();
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
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
                                    ),

                                    // ---------- PRICE × QTY ----------
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
                              offset: const Offset(0, 2),
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

                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ),
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
