import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'home_screen.dart'; // Import các màn hình con
import 'profile_screen.dart';
import 'favorites_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  // Chỉ số của màn hình đang được chọn
  int _selectedIndex = 0;

  // Danh sách các màn hình con tương ứng với các tab
  final List<Widget> _screens = const [
    HomeScreen(),
    // ProfileScreen(),
    // FavoritesScreen(),
    // Màn hình giỏ hàng có thể được xử lý riêng, không cần ở đây
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      // Hiển thị màn hình con dựa trên chỉ số được chọn
      body: IndexedStack(index: _selectedIndex, children: _screens),
      // Thanh Bottom Navigation tùy chỉnh
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed, // Cố định các icon
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false, // Ẩn label giống hình ảnh
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            // Tab Home
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Icon(
                  _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  size: 28,
                ),
              ),
              label: 'Home',
            ),
            // Tab Profile
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Icon(
                  _selectedIndex == 1 ? Icons.person : Icons.person_outline,
                  size: 28,
                ),
              ),
              label: 'Profile',
            ),
            // Tab Favorites
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Icon(
                  _selectedIndex == 2 ? Icons.favorite : Icons.favorite_outline,
                  size: 28,
                ),
              ),
              label: 'Favorites',
            ),
            // Tab Giỏ hàng - Widget đặc biệt
            BottomNavigationBarItem(icon: _buildCartIcon(), label: 'Cart'),
          ],
        ),
      ),
    );
  }

  // Phương thức để xây dựng icon Giỏ hàng màu xanh lá cây
  Widget _buildCartIcon() {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: AppColors.primary, // Màu xanh lá cây
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: const Icon(
        Icons.shopping_bag_outlined,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}
