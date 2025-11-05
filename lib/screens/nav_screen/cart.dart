import 'package:comercial_app/screens/global_screen/global.dart';
import 'package:comercial_app/screens/order_screen/orderpayment.dart';
import 'package:comercial_app/screens/product_screen/product.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _couponController = TextEditingController();

  bool _isEditingAddress = false;
  bool _isEditingCoupon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'ITEMS',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'DESCRIPTION',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'PRICE',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  ListView.builder(
                    itemBuilder: (context, index) {
                      final cart = carts[index];
                      return ListTile(
                        leading: cart['image'],
                        title: cart['brandname'],
                        subtitle: cart['name'],
                        trailing: cart['price'],
                      );
                    },
                  ),

                  const Divider(thickness: 1.2),
                  const SizedBox(height: 10),

                  _buildEditableRow(
                    title: 'SHIPPING',
                    hint: 'Add Shipping Address',
                    controller: _addressController,
                    isEditing: _isEditingAddress,
                    onTap: () {
                      setState(() {
                        _isEditingAddress = !_isEditingAddress;
                      });
                    },
                  ),
                  _buildInfoRow(title: 'DELIVERY', subtitle: 'Free | 3-4 days'),
                  _buildInfoRow(title: 'PAYMENT', subtitle: 'Visa *1234'),
                  _buildEditableRow(
                    title: 'COUPON',
                    hint: 'Apply Coupon Code',
                    controller: _couponController,
                    isEditing: _isEditingCoupon,
                    onTap: () {
                      setState(() {
                        _isEditingCoupon = !_isEditingCoupon;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'RS.1450',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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
                    children: const [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'RS.1450',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          Container(
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
                backgroundColor: Color(0xFFC19375),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderPaymentPage()),
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
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String title, required String subtitle}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Row(
              children: [
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
                const SizedBox(width: 5),
                const Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }

  Widget _buildEditableRow({
    required String title,
    required String hint,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Text(
                    controller.text.isNotEmpty ? controller.text : hint,
                    style: TextStyle(
                      color: controller.text.isNotEmpty
                          ? Colors.black
                          : Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    isEditing
                        ? Icons.keyboard_arrow_up
                        : Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
        if (isEditing) ...[
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }

  // ---- Cart Item ----
  Widget _buildCartItem({
    required String imagePath,
    required String title,
    required String subtitle,
    required String desc,
    required String qty,
    required String price,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(subtitle, style: const TextStyle(fontSize: 14)),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text('Qty: $qty', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
