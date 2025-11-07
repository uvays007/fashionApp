import 'package:comercial_app/helper/timehelper.dart';
import 'package:comercial_app/screens/global_screen/global.dart';
import 'package:flutter/material.dart';

class OrderPaymentPage extends StatefulWidget {
  final String total;
  const OrderPaymentPage({super.key, required this.total});

  @override
  State<OrderPaymentPage> createState() => _OrderPaymentPageState();
}

class _OrderPaymentPageState extends State<OrderPaymentPage> {
  String _selectedPayment = "UPI";
  final TextEditingController _upiController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Order Confirmation"),
        backgroundColor: const Color(0xFFC19375),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSummaryRow("Items Total", widget.total),
            _buildSummaryRow("Shipping", "Free"),
            const Divider(),
            _buildSummaryRow("Total Amount", widget.total, bold: true),
            const SizedBox(height: 30),

            const Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _buildPaymentOption("UPI"),
            _buildPaymentOption("Debit Card"),

            const SizedBox(height: 20),
            if (_selectedPayment == "UPI") _buildUPISection(),
            if (_selectedPayment == "Debit Card") _buildCardSection(),

            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC19375),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                _showPaymentSuccess(context);
              },
              child: const Text(
                "Confirm & Pay",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, var value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method) {
    return RadioListTile<String>(
      title: Text(method),
      value: method,
      groupValue: _selectedPayment,
      activeColor: const Color(0xFFC19375),
      onChanged: (value) {
        setState(() {
          _selectedPayment = value!;
        });
      },
    );
  }

  Widget _buildUPISection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enter UPI ID",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _upiController,
          decoration: InputDecoration(
            hintText: "example@upi",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: const Icon(Icons.account_balance_wallet),
          ),
        ),
      ],
    );
  }

  Widget _buildCardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enter Card Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _cardController,
          decoration: InputDecoration(
            hintText: "Card Number",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: const Icon(Icons.credit_card),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "MM/YY",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.datetime,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "CVV",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showPaymentSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 10),
            const Text(
              "Payment Successful!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your order has been placed successfully.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC19375),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                orders.addAll(carts);

                String productNames = carts
                    .map((item) => item['name'])
                    .join(", ");

                notifications.add({
                  "message":
                      "Your order for $productNames has been placed successfully!",
                  "time": timeAgo(DateTime.now()),
                });

                carts.clear();

                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
