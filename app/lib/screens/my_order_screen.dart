import 'package:flutter/material.dart';
import 'track_order_screen.dart'; // Import màn hình chi tiết

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Order",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 4, // Số lượng đơn hàng mẫu
        itemBuilder: (context, index) {
          return _buildOrderCard(context);
        },
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(15),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.inventory_2_outlined, color: Colors.green),
          ),
          title: const Text(
            "Order #90897",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: const Text(
            "Placed on October 19 2021\nItems: 10   Items: \$16.90",
            style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
          ),
          trailing: const Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: Colors.green,
          ),
          children: [
            const Divider(indent: 20, endIndent: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  _buildSimpleStatusRow("Order placed", "Oct 19 2021", true),
                  _buildSimpleStatusRow("Order confirmed", "Oct 20 2021", true),
                  _buildSimpleStatusRow("Order shipped", "Oct 20 2021", true),
                  _buildSimpleStatusRow("Out for delivery", "pending", false),
                ],
              ),
            ),
            // Nút bấm để xem chi tiết Track Order
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrackOrderScreen(),
                  ),
                );
              },
              child: const Text(
                "View Tracking Details",
                style: TextStyle(color: Colors.green),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleStatusRow(String title, String date, bool isDone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isDone ? Colors.green : Colors.grey[300],
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(color: isDone ? Colors.black : Colors.grey),
          ),
          const Spacer(),
          Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
