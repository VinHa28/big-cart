// lib/models/cart_item.dart

import 'package:app/models/product.dart';

class CartItem {
  final Product product;
  int quantity; 

  CartItem({required this.product, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      // API thường trả về field 'product' chứa object chi tiết sản phẩm
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.id, // Khi gửi lên server thường chỉ cần gửi ID
      'quantity': quantity,
    };
  }
}
