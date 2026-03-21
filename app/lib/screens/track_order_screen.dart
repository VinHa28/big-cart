import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Track Order",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Card thông tin đơn hàng ở trên cùng
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #90897",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Placed on October 19 2021",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      Text(
                        "Items: 10    Items: \$16.90",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Timeline Tracking
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildTrackStep(
                    "Order Placed",
                    "October 21 2021",
                    Icons.inventory_2_outlined,
                    true,
                    true,
                  ),
                  _buildTrackStep(
                    "Order Confirmed",
                    "October 21 2021",
                    Icons.check_circle_outline,
                    true,
                    true,
                  ),
                  _buildTrackStep(
                    "Order Shipped",
                    "October 21 2021",
                    Icons.local_shipping_outlined,
                    true,
                    true,
                  ),
                  _buildTrackStep(
                    "Out for Delivery",
                    "Pending",
                    Icons.delivery_dining_outlined,
                    false,
                    true,
                  ),
                  _buildTrackStep(
                    "Order Delivered",
                    "Pending",
                    Icons.shopping_cart_outlined,
                    false,
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackStep(
    String title,
    String date,
    IconData icon,
    bool isCompleted,
    bool hasLine,
  ) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // Phần Icon và Line
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFFE8F5E9)
                      : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isCompleted ? Colors.green : Colors.grey[400],
                  size: 25,
                ),
              ),
              if (hasLine)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? Colors.green : Colors.grey[200],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Phần Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isCompleted ? Colors.black : Colors.grey[400],
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
                const SizedBox(height: 30), // Khoảng cách giữa các bước
              ],
            ),
          ),
        ],
      ),
    );
  }
}
