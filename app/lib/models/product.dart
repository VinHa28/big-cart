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
    // Xử lý an toàn cho Category để tránh lỗi 'String' is not a subtype of 'int'
    String catId = '';
    String catName = '';

    if (json['category'] != null) {
      if (json['category'] is Map<String, dynamic>) {
        // Nếu đã populate thành Object
        catId = json['category']['_id']?.toString() ?? '';
        catName = json['category']['name']?.toString() ?? '';
      } else {
        // Nếu chỉ là String ID
        catId = json['category'].toString();
      }
    }

    return Product(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      // Ép kiểu num an toàn trước khi toDouble
      price: (json['price'] ?? 0).toDouble(),
      unit: json['unit'] ?? '',
      stock: json['stock'] ?? 0,
      image: json['image'] is String
          ? json['image']
          : json['image']?['url'] ?? '',
      categoryId: catId,
      isActive: json['isActive'] ?? true,
      categoryName: catName,
    );
  }
}
