import 'package:app/models/product.dart';
import 'package:app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // Màu nền xám nhạt như hình
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            // Nút yêu thích (Tim)
            Positioned(
              top: 10,
              right: 10,
              child: Icon(Icons.favorite_border, color: Colors.grey, size: 20),
            ),

            Column(
              children: [
                const SizedBox(height: 15),
                // Ảnh sản phẩm
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: product.image.startsWith('http')
                        ? Image.network(product.image, fit: BoxFit.contain)
                        : Image.asset(product.image, fit: BoxFit.contain),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      // Giá sản phẩm
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Tên sản phẩm
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Đơn vị (Unit)
                      Text(
                        product.unit,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 20),

                // Nút Add to Cart
                InkWell(
                  onTap: onAdd,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Add to cart",
                          style: TextStyle(
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
}
