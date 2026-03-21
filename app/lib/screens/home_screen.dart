import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      // Sử dụng CustomScrollView để thanh Search Bar có thể cuộn lên
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Thanh Search Bar (đặt trên cùng)
            SliverAppBar(
              backgroundColor: AppColors.scaffoldBackground,
              elevation: 0,
              floating: true, // Thanh Search sẽ mờ đi khi cuộn
              pinned: false,
              title: _buildSearchBar(),
            ),

            // Phần nội dung chính
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề Categories
                    _buildSectionHeader('Categories'),
                    const SizedBox(height: 15),
                    // ... (Phần Category Cards sẽ được thêm vào đây sau)
                    const SizedBox(height: 20),

                    // Tiêu đề Featured Products
                    _buildSectionHeader('Featured products'),
                    const SizedBox(height: 15),
                    // ... (Phần Product Grid sẽ được thêm vào đây sau)
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget xây dựng Search Bar
  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search keywords..',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          // Icon lọc ở bên phải
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_list_outlined, color: Colors.grey),
            onPressed: () {},
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  // Widget xây dựng Tiêu đề các mục (với icon >)
  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Icon(Icons.chevron_right, color: Colors.grey, size: 28),
      ],
    );
  }
}
