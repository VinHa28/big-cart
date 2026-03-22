import 'package:app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75, // Độ rộng cố định cho mỗi item
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            // Phần vòng tròn chứa ảnh
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withValues(alpha: 0.075),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(
                12,
              ), // Tạo khoảng cách cho ảnh bên trong
              child: _buildImage(),
            ),
            const SizedBox(height: 6),
            // Tên danh mục
            Expanded(
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    final image = category.image;

    // 1. Nếu là SVG (ưu tiên check trước)
    if (image.endsWith('.svg')) {
      if (image.startsWith('http')) {
        return SvgPicture.network(
          image,
          fit: BoxFit.contain,
          placeholderBuilder: (context) =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      } else {
        return SvgPicture.asset(image, fit: BoxFit.contain);
      }
    }

    // 2. Nếu là ảnh thường (png, jpg...)
    if (image.startsWith('http')) {
      return Image.network(
        image,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported, size: 20),
      );
    } else {
      return Image.asset(image, fit: BoxFit.contain);
    }
  }
}
