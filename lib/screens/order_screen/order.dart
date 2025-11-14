import 'package:flutter/material.dart';
import 'package:comercial_app/theme/Textstyles.dart';
import 'package:comercial_app/screens/global_screen/global.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFC19375),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: orders.isEmpty
            ? const Center(
                child: Text(
                  "No Orders Yet",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final isPlaced = order['isPlaced'] ?? false;
                  final status = order['status'] ?? "In Transit";
                  final orderId = order['orderId'] ?? "#0000";

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              Image.asset(
                                order['image'],
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'Qty: ${order['qty'].toString()}',
                                style: AppTextStyles.bold,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order['brandname'],
                                style: AppTextStyles.semiBold.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order['name'],
                                style: AppTextStyles.medium.copyWith(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    "Order ID: $orderId",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: _getStatusColor(status),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    status,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getStatusColor(status),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'size: ${order['size']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Icon(
                                        isPlaced
                                            ? Icons.check_circle
                                            : Icons.cancel_outlined,
                                        color: isPlaced
                                            ? Colors.green
                                            : Colors.redAccent,
                                        size: 18,
                                      ),
                                      Text(
                                        isPlaced
                                            ? "Order Placed"
                                            : "Not Placed",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isPlaced
                                              ? Colors.green
                                              : Colors.redAccent,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 30),
                          child: Text(
                            order['price'],
                            style: AppTextStyles.bold.copyWith(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'in transit':
        return Colors.orange;
      case 'cancelled':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }
}
