import 'package:app/constants/app_colors.dart';
import 'package:app/models/address.dart';
import 'package:app/services/address_service.dart';
import 'package:app/services/order_service.dart';
import 'package:app/screens/my_address_screen.dart';
import 'package:flutter/material.dart';
import '../models/cart.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double subtotal;
  final double shipping;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.subtotal,
    required this.shipping,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final AddressService _addressService = AddressService();
  final OrderService _orderService = OrderService();
  final String userId = "69bfa2020213cda8607ee688";

  Address? _selectedAddress;
  bool _isLoadingAddress = true;
  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();
    _loadDefaultAddress();
  }

  Future<void> _loadDefaultAddress() async {
    try {
      final addresses = await _addressService.getAllAddresses(userId);
      if (addresses.isNotEmpty) {
        setState(() {
          _selectedAddress = addresses.firstWhere(
            (a) => a.isDefault,
            orElse: () => addresses.first,
          );
        });
      }
    } catch (e) {
      debugPrint("Error loading address: $e");
    } finally {
      setState(() => _isLoadingAddress = false);
    }
  }

  void _handlePlaceOrder() async {
    if (_selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng chọn địa chỉ giao hàng")),
      );
      return;
    }

    setState(() => _isPlacingOrder = true);
    final success = await _orderService.createOrder(
      userId: userId,
      address: _selectedAddress!.toJson(),
    );
    setState(() => _isPlacingOrder = false);

    if (success) {
      _showSuccessDialog(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đặt hàng thất bại. Vui lòng thử lại.")),
      );
    }
  }

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
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              "Delivery Address",
              onEdit: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyAddressScreen()),
                );
                _loadDefaultAddress();
              },
            ),
            _isLoadingAddress
                ? const Center(child: CircularProgressIndicator())
                : _buildAddressCard(),
            const SizedBox(height: 25),
            _buildSectionHeader("Order Summary"),
            _buildOrderSummary(),
            const SizedBox(height: 25),
            _buildTotalSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onEdit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (onEdit != null)
          TextButton(
            onPressed: onEdit,
            child: const Text(
              "Change",
              style: TextStyle(color: AppColors.primary),
            ),
          ),
      ],
    );
  }

  Widget _buildAddressCard() {
    if (_selectedAddress == null) return const Text("Chưa có địa chỉ nào.");
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: AppColors.primary, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedAddress!.fullname,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${_selectedAddress!.address}, ${_selectedAddress!.city}",
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _selectedAddress!.phoneNumber,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: widget.cartItems.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Giúp căn chỉnh khi text xuống dòng
              children: [
                // 1. Phần tên sản phẩm (Sử dụng Expanded để chống tràn)
                Expanded(
                  flex: 3,
                  child: Text(
                    "${item.product.name} x${item.quantity}",
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                // 2. Phần giá tiền
                Expanded(
                  flex: 2,
                  child: Text(
                    "\$${(item.product.price * item.quantity).toStringAsFixed(2)}",
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _summaryRow("Subtotal", "\$${widget.subtotal.toStringAsFixed(2)}"),
          _summaryRow("Shipping", "\$${widget.shipping.toStringAsFixed(2)}"),
          const Divider(height: 30),
          _summaryRow(
            "Total",
            "\$${(widget.subtotal + widget.shipping).toStringAsFixed(2)}",
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        // Dùng Flexible cho giá trị Total đề phòng con số quá lớn
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: _isPlacingOrder ? null : _handlePlaceOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: _isPlacingOrder
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  "Place Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.primary, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Order Success!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                "/home",
                (route) => false,
              ),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
