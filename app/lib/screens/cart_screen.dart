import 'package:app/models/cart.dart';
import 'package:app/services/cart_service.dart';
import 'package:app/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/cart_item_widget.dart';
import '../constants/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  Cart? _cart;
  bool _isLoading = true;

  // Giả sử lấy userId từ login, ở đây dùng ID cứng để test theo yêu cầu của bạn
  final String userId = "69bfa2020213cda8607ee688";
  double shipping = 1.6;

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  // Lấy dữ liệu giỏ hàng từ backend
  Future<void> fetchCart() async {
    setState(() => _isLoading = true);
    final data = await _cartService.getCart(userId);
    setState(() {
      _cart = data;
      _isLoading = false;
    });
  }

  // Xử lý tăng số lượng (Add)
  void _handleIncrease(String productId) async {
    final success = await _cartService.addToCart(
      userId: userId,
      productId: productId,
      quantity: 1,
    );
    if (success) {
      fetchCart(); // Cập nhật lại UI từ server
    }
  }

  // Xử lý giảm số lượng (Remove bớt 1)
  void _handleDecrease(String productId) async {
    final updatedCart = await _cartService.removeFromCart(userId, productId);
    if (updatedCart != null) {
      setState(() => _cart = updatedCart); // Cập nhật state với data mới
    } else {
      // Nếu có lỗi hoặc item cuối cùng bị xóa, load lại để chắc chắn
      fetchCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Kiểm tra trạng thái loading hoặc giỏ hàng trống
    bool isCartEmpty = _cart == null || _cart!.items.isEmpty;

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
          "Shopping Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : isCartEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _cart!.items.length,
                    itemBuilder: (context, index) {
                      final item = _cart!.items[index];
                      return CartItemWidget(
                        cartItem: item,
                        onAdd: () => _handleIncrease(item.product.id),
                        onRemove: () => _handleDecrease(item.product.id),
                      );
                    },
                  ),
                ),
                _buildOrderSummary(),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return const Center(child: Text("Giỏ hàng của bạn đang trống"));
  }

  Widget _buildOrderSummary() {
    final subtotal = _cart?.totalPrice ?? 0.0;
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSummaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
          const SizedBox(height: 10),
          _buildSummaryRow("Shipping", "\$${shipping.toStringAsFixed(2)}"),
          const Divider(height: 30),
          _buildSummaryRow(
            "Total",
            "\$${(subtotal + shipping).toStringAsFixed(2)}",
            isTotal: true,
          ),
          const SizedBox(height: 20),
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          // Điều hướng sang Checkout và truyền dữ liệu thật
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutScreen(
                cartItems: _cart!.items,
                subtotal: _cart!.totalPrice,
                shipping: shipping,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          "Checkout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
