class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String unit;
  final int stock;
  final String image;
  final String categoryId;
  final bool isActive;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.unit,
    required this.stock,
    required this.image,
    required this.categoryId,
    required this.isActive,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      unit: json['unit'],
      stock: json['stock'],
      image: json['image'] ?? '',
      categoryId: json['category'],
      isActive: json['isActive'],
    );
  }
}
