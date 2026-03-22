import 'package:app/screens/cart_screen.dart';
import 'package:app/screens/favorites_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  // 1. Tạo GlobalKey để điều khiển CartScreen từ đây
  final GlobalKey<CartScreenState> _cartKey = GlobalKey<CartScreenState>();

  // 2. Sử dụng late để khởi tạo danh sách screens sau khi _cartKey đã sẵn sàng
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // 3. Khởi tạo danh sách các màn hình (Lưu ý: Không dùng const ở đây)
    _screens = [
      const HomeScreen(),
      const AccountScreen(),
      const FavoritesScreen(),
      CartScreen(key: _cartKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: IndexedStack(index: _selectedIndex, children: _screens),
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

            // 4. KIỂM TRA: Nếu người dùng nhấn vào tab Cart (index 3)
            if (index == 3) {
              // Gọi hàm fetchCart() công khai bên trong CartScreen
              _cartKey.currentState?.fetchCart();
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            _buildNavItem(0, Icons.home, Icons.home_outlined, 'Home'),
            _buildNavItem(1, Icons.person, Icons.person_outline, 'Profile'),
            _buildNavItem(
              2,
              Icons.favorite,
              Icons.favorite_outline,
              'Favorites',
            ),
            _buildNavItem(
              3,
              Icons.shopping_cart,
              Icons.shopping_cart_outlined,
              'Cart',
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    int index,
    IconData selectedIcon,
    IconData unselectedIcon,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Icon(
          _selectedIndex == index ? selectedIcon : unselectedIcon,
          size: 28,
        ),
      ),
      label: label,
    );
  }
}
