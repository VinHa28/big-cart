import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String description;
  final String image;
  final String color; // lưu raw từ DB

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      color: json['color'] ?? '9E9E9E',
    );
  }

  /// Convert HEX string (E6F2EA) -> Color
  Color get colorValue {
    final hex = color.replaceAll('#', '');
    return Color(int.parse('0xFF$hex'));
  }
}
