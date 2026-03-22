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
  final String categoryName;

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
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      unit: json['unit'] ?? '',
      stock: json['stock'] ?? 0,
      image: json['image'] is String
          ? json['image']
          : json['image']?['url'] ?? '',

      categoryId: json['category'] != null ? json['category']['_id'] ?? '' : '',
      isActive: json['isActive'] ?? true,
      categoryName: json['category'] != null
          ? json['category']['name'] ?? ''
          : '',
    );
  }
}
