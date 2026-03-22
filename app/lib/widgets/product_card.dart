import 'package:app/models/product.dart';
import 'package:app/screens/product_detail_screen.dart';
import 'package:app/services/cart_service.dart'; // Import service
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  // Giữ lại onAdd để thông báo cho màn hình cha nếu cần (ví dụ hiện SnackBar)
  final VoidCallback? onAdd;

  const ProductCard({super.key, required this.product, this.onAdd});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CartService _cartService = CartService();
  bool _isAdding = false;

  // Giả sử lấy userId cố định để test (hoặc từ AuthProvider/Storage)
  final String userId = "69bfa2020213cda8607ee688";

  void _handleAddToCart() async {
    setState(() => _isAdding = true);

    final success = await _cartService.addToCart(
      userId: userId,
      productId: widget.product.id,
      quantity: 1,
    );

    setState(() => _isAdding = false);

    if (success) {
      // Hiển thị SnackBar ngay tại ProductCard (tùy chọn)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Đã thêm ${widget.product.name} vào giỏ hàng!"),
            backgroundColor: AppColors.primary,
            duration: const Duration(seconds: 2),
          ),
        );
      }

      // Gọi callback onAdd để thông báo cho màn hình cha (HomeScreen)
      widget.onAdd?.call();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Thêm vào giỏ hàng thất bại")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: 10,
              right: 10,
              child: Icon(Icons.favorite_border, color: Colors.grey, size: 20),
            ),
            Column(
              children: [
                const SizedBox(height: 15),
                Expanded(
                  child: Hero(
                    tag: 'prod-${widget.product.id}',
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _buildImage(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        "\$${widget.product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.product.unit,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 20),
                InkWell(
                  onTap: _isAdding
                      ? null
                      : _handleAddToCart, // Chặn bấm liên tục
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isAdding
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primary,
                                ),
                              )
                            : const Icon(
                                Icons.shopping_bag_outlined,
                                color: AppColors.primary,
                                size: 18,
                              ),
                        const SizedBox(width: 8),
                        Text(
                          _isAdding ? "Adding..." : "Add to cart",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildImage() giữ nguyên như code cũ của bạn...
  Widget _buildImage() {
    final image = widget.product.image;
    if (image.endsWith('.svg')) {
      return image.startsWith('http')
          ? SvgPicture.network(image, fit: BoxFit.contain)
          : SvgPicture.asset(image, fit: BoxFit.contain);
    }
    return image.startsWith('http')
        ? Image.network(image, fit: BoxFit.contain)
        : Image.asset(image, fit: BoxFit.contain);
  }
}
