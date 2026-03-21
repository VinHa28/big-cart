import 'package:app/models/cart.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool
  isCart; // true: hiện bộ tăng giảm số lượng, false: ẩn (cho Favorites)

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onAdd,
    required this.onRemove,
    this.isCart = true,
  });

  @override
  Widget build(BuildContext context) {
    // Truy cập trực tiếp thông tin từ object product bên trong cartItem
    final product = cartItem.product;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ảnh sản phẩm
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: product.image.startsWith('http')
                ? Image.network(product.image, fit: BoxFit.contain)
                : Image.asset(product.image, fit: BoxFit.contain),
          ),
          const SizedBox(width: 15),

          // Thông tin sản phẩm lấy từ model Product bên trong CartItem
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${product.price} x ${cartItem.quantity}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.unit,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),

          // Bộ điều khiển số lượng (Chỉ hiện nếu là màn hình Cart)
          if (isCart)
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green, size: 20),
                  onPressed: onAdd,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
                Text(
                  "${cartItem.quantity}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.green, size: 20),
                  onPressed: onRemove,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
