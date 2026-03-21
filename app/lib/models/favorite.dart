import 'package:app/models/product.dart';

class FavoriteItem {
  final Product product; // Thay String productId bằng Product

  FavoriteItem({required this.product});

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      product: Product.fromJson(json['product']), // Lấy object product
    );
  }
}

class Favorite {
  final String id;
  final String userId;
  final List<FavoriteItem> items;

  Favorite({required this.id, required this.userId, required this.items});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['_id'],
      userId: json['user'],
      items: (json['items'] as List)
          .map((item) => FavoriteItem.fromJson(item))
          .toList(),
    );
  }
}
