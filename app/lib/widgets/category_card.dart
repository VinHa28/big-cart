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
                color: category.colorValue,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(
                12,
              ), // Tạo khoảng cách cho ảnh bên trong
              child: category.image.startsWith('http')
                  ? Image.network(category.image, fit: BoxFit.contain)
                  : category.image.endsWith('.svg')
                  ? SvgPicture.asset(
                      category.image,
                      fit: BoxFit.contain,
                      placeholderBuilder: (context) =>
                          const CircularProgressIndicator(),
                    )
                  : Image.asset(category.image, fit: BoxFit.contain),
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
}
