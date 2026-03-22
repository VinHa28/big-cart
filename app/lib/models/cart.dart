import 'package:app/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    dynamic productData = json['product'];
    Map<String, dynamic> targetMap;

    if (productData is Map<String, dynamic>) {
      targetMap = productData;
    } else if (productData is List && productData.isNotEmpty) {
      targetMap = productData[0] is Map<String, dynamic>
          ? productData[0]
          : throw Exception("Dữ liệu sản phẩm trong mảng không hợp lệ");
    } else {
      throw Exception("Trường product không phải Object hoặc Array hợp lệ");
    }

    return CartItem(
      product: Product.fromJson(targetMap),
      quantity: json['quantity'] is int
          ? json['quantity']
          : int.tryParse(json['quantity'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'product': product.id,
    'quantity': quantity,
  };
}

class Cart {
  final String id;
  final String userId;
  final List<CartItem> items;

  Cart({required this.id, required this.userId, required this.items});

  factory Cart.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'];
    List<CartItem> parsedItems = [];

    if (rawItems is List) {
      parsedItems = rawItems.map((item) => CartItem.fromJson(item)).toList();
    } else if (rawItems is Map) {
      parsedItems = rawItems.values
          .map((item) => CartItem.fromJson(item))
          .toList();
    }

    return Cart(
      id: json['_id'] ?? '',
      userId: json['user'] ?? '',
      items: parsedItems,
    );
  }

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
}
