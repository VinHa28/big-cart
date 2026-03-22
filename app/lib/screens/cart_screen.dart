import 'package:app/mock/mock_data.dart';
import 'package:app/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/cart_item_widget.dart';
import '../constants/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get subtotal => cartItems.fold(
    0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );
  double shipping = 1.6;

  @override
  Widget build(BuildContext context) {
    // Biến kiểm tra giỏ hàng trống
    bool isCartEmpty = cartItems.isEmpty;

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
      // LOGIC THAY ĐỔI BODY TẠI ĐÂY
      body: isCartEmpty
          ? _buildEmptyCartBody(context) // Nếu trống, hiện Empty Body
          : _buildActiveCartBody(), // Nếu có hàng, hiện Active Body (Code cũ)
    );
  }

  Widget _buildEmptyCartBody(BuildContext context) {
    return Column(
      children: [
        // Phần nội dung chính ở giữa
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon túi mua sắm màu xanh lá cây
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 100,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 30),
                // Tiêu đề
                const Text(
                  "Your cart is empty !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                // Phụ đề (Bạn có thể đổi text này cho phù hợp logic)
                Text(
                  "You will get a response within\na few minutes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Nút "Start shopping" cố định ở dưới cùng
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Start shopping",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 2. WIDGET CHO MÀN HÌNH ACTIVE CART (CODE CŨ)
  // ==========================================
  Widget _buildActiveCartBody() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];

              return Dismissible(
                key: Key(item.product.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    cartItems.removeAt(index);
                  });
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                child: CartItemWidget(
                  cartItem: item,
                  onAdd: () => setState(() => item.quantity++),
                  onRemove: () {
                    if (item.quantity > 1) {
                      setState(() => item.quantity--);
                    }
                  },
                ),
              );
            },
          ),
        ),
        _buildCheckoutSection(),
      ],
    );
  }

  // Phần tính tổng tiền (Dành cho Active Cart)
  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Text(
                "\$${subtotal.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Shipping charges",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Text(
                "\$${shipping.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${(subtotal + shipping).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                      cartItems: cartItems,
                      subtotal: subtotal,
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
          ),
        ],
      ),
    );
  }
}
