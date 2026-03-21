import 'package:app/models/product.dart';

List<Product> mockProducts = [
  Product(
    id: "1",
    name: "Táo đỏ",
    description: "Táo nhập khẩu",
    price: 50000,
    unit: "kg",
    stock: 10,
    image:
        "https://res.cloudinary.com/vinhhv2807/image/upload/v1774017667/avacoda_zk98k7.png",
    categoryId: "c1",
    isActive: true,
  ),
  Product(
    id: "2",
    name: "Cá hồi",
    description: "Cá hồi tươi",
    price: 200000,
    unit: "kg",
    stock: 5,
    image:
        "https://res.cloudinary.com/vinhhv2807/image/upload/v1774017667/avacoda_zk98k7.png",
    categoryId: "c2",
    isActive: true,
  ),
];
