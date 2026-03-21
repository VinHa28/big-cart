import 'package:app/models/category.dart';
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

final List<Category> dummyCategories = [
  Category(
    id: '1',
    name: 'Vegetables',
    description: '',
    image: 'assets/images/category/category_1.svg',
  ),
  Category(
    id: '2',
    name: 'Fruits',
    description: '',
    image: 'assets/images/category/category_2.svg',
  ),
  Category(
    id: '3',
    name: 'Beverages',
    description: '',
    image: 'assets/images/category/category_3.svg',
  ),
  Category(
    id: '4',
    name: 'Grocery',
    description: '',
    image: 'assets/images/category/category_4.svg',
  ),
  Category(
    id: '5',
    name: 'Household',
    description: '',
    image: 'assets/images/category/category_5.svg',
  ),
  Category(
    id: '6',
    name: 'Edible oil',
    description: '',
    image: 'assets/images/category/category_6.svg',
  ),
  Category(
    id: '7',
    name: 'Babycare',
    description: '',
    image: 'assets/images/category/category_7.svg',
  ),
];
