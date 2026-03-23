import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  final dynamic order; // Nhận dữ liệu đơn hàng từ màn hình trước

  const TrackOrderScreen({super.key, required this.order});

  // Hàm xác định xem một bước đã hoàn thành hay chưa dựa trên status của đơn hàng
  bool _isStepCompleted(String stepStatus) {
    final status = order['status'] ?? 'pending';

    // Thứ tự ưu tiên của trạng thái
    const statusOrder = ['pending', 'paid', 'shipped', 'completed'];

    int currentIdx = statusOrder.indexOf(status);
    int stepIdx = statusOrder.indexOf(stepStatus);

    // Nếu đơn hàng bị cancel, xử lý riêng hoặc coi như không bước nào xong
    if (status == 'cancelled') return false;

    return currentIdx >= stepIdx;
  }

  @override
  Widget build(BuildContext context) {
    final String orderId = order['_id'] ?? '';
    final List items = order['items'] ?? [];

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
            // Card thông tin tổng quan
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
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order #...${orderId.substring(orderId.length - 6).toUpperCase()}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${items.length} Items  •  \$${(order['total'] ?? 0).toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Danh sách các bước tracking
            _buildTrackStep(
              icon: Icons.receipt_long,
              title: "Order Placed",
              subtitle: "We have received your order",
              isCompleted: _isStepCompleted('pending'),
              hasLine: true,
            ),
            _buildTrackStep(
              icon: Icons.payment,
              title: "Payment Confirmed",
              subtitle: "Order has been paid successfully",
              isCompleted: _isStepCompleted('paid'),
              hasLine: true,
            ),
            _buildTrackStep(
              icon: Icons.local_shipping,
              title: "Shipped",
              subtitle: "Your order is on the way",
              isCompleted: _isStepCompleted('shipped'),
              hasLine: true,
            ),
            _buildTrackStep(
              icon: Icons.check_circle,
              title: "Completed",
              subtitle: "Order delivered successfully",
              isCompleted: _isStepCompleted('completed'),
              hasLine: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool hasLine,
  }) {
    return SizedBox(
      height: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần cột Icon và Line
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.primary : Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isCompleted ? Colors.white : Colors.grey[400],
                  size: 20,
                ),
              ),
              if (hasLine)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? AppColors.primary : Colors.grey[200],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Phần nội dung chữ
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  subtitle,
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
