class OrderItem {
  final String productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });
}

class Order {
  final String id;
  final List<OrderItem> items;
  final double total;
  final String status;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
  });
}
