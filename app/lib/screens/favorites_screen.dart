import 'package:app/models/cart.dart';
import 'package:app/models/favorite.dart';
import 'package:app/models/product.dart';
import 'package:flutter/material.dart';
import '../widgets/cart_item_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Giả lập dữ liệu theo đúng model Favorite của bạn
  late Favorite myFavorites;

  @override
  void initState() {
    super.initState();
    // Khởi tạo dữ liệu mẫu
    myFavorites = Favorite(
      id: 'fav_001',
      userId: 'user_001',
      items: [
        FavoriteItem(
          product: Product(
            id: '1',
            name: 'Fresh Broccoli',
            price: 2.22,
            unit: '1.50 lbs',
            image: 'assets/images/products/broccoli.png',
            description: '',
            stock: 10,
            categoryId: '1',
            isActive: true,
          ),
        ),
        FavoriteItem(
          product: Product(
            id: '2',
            name: 'Black Grapes',
            price: 2.22,
            unit: '5.0 lbs',
            image: 'assets/images/products/grapes.png',
            description: '',
            stock: 10,
            categoryId: '1',
            isActive: true,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
          "Favorites",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: myFavorites.items.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: myFavorites.items.length,
              itemBuilder: (context, index) {
                final favoriteItem = myFavorites.items[index];
                final product = favoriteItem.product;

                // Chuyển đổi sang CartItem để dùng CartItemWidget (quantity mặc định là 1)
                final displayItem = CartItem(product: product, quantity: 1);

                return Dismissible(
                  key: Key(product.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      myFavorites.items.removeAt(index);
                    });
                    // Gọi API xóa favorite tại đây
                  },
                  background: _buildDeleteBackground(),
                  child: CartItemWidget(
                    cartItem: displayItem,
                    isCart: false, // Ẩn bộ tăng giảm số lượng
                    onAdd: () {},
                    onRemove: () {},
                  ),
                );
              },
            ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.delete_outline, color: Colors.red, size: 30),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            "No favorites yet",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
