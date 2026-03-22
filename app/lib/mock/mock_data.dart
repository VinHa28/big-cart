import 'package:app/models/address.dart';
import 'package:app/models/cart.dart';
import 'package:app/models/category.dart';
import 'package:app/models/product.dart';

final List<Category> dummyCategories = [
  Category(
    id: '1',
    name: 'Vegetables',
    description: '',
    image: 'assets/images/category/category_1.svg',
    color: 'E6F2EA',
  ),
  Category(
    id: '2',
    name: 'Fruits',
    description: '',
    image: 'assets/images/category/category_2.svg',
    color: 'FFE9E5',
  ),
  Category(
    id: '3',
    name: 'Beverages',
    description: '',
    image: 'assets/images/category/category_3.svg',
    color: 'FFF6E3',
  ),
  Category(
    id: '4',
    name: 'Grocery',
    description: '',
    image: 'assets/images/category/category_4.svg',
    color: 'F3EFFA',
  ),
  Category(
    id: '5',
    name: 'Household',
    description: '',
    image: 'assets/images/category/category_5.svg',
    color: 'DCF4F5',
  ),
  Category(
    id: '6',
    name: 'Edible oil',
    description: '',
    image: 'assets/images/category/category_6.svg',
    color: 'FFE8F2',
  ),
  Category(
    id: '7',
    name: 'Babycare',
    description: '',
    image: 'assets/images/category/category_7.svg',
    color: 'D2EFFF',
  ),
];

final List<Product> dummyProducts = [
  Product(
    id: '1',
    categoryName: "",
    name: 'Fresh Peach',
    description:
        'Fresh peaches are juicy and naturally sweet. They may have slight marks on the skin, but inside they are soft, fragrant, and full of flavor.',
    price: 8.0,
    unit: 'dozen',
    stock: 10,
    image: 'assets/images/products/peach.png',
    categoryId: 'cat1',
    isActive: true,
  ),
  Product(
    id: '2',
    categoryName: "",
    name: 'Avocado',
    description:
        'Avocados are creamy and rich in healthy fats. Their slightly rough skin hides a smooth, buttery texture perfect for salads and spreads.',
    price: 7.0,
    unit: '2.0 lbs',
    stock: 5,
    image: 'assets/images/products/avacoda.png',
    categoryId: 'cat1',
    isActive: true,
  ),
  Product(
    id: '3',
    categoryName: "",
    name: 'Pineapple',
    description:
        'Pineapples are tropical fruits with a sweet and tangy taste. Their tough outer skin protects the juicy, refreshing flesh inside.',
    price: 7.0,
    unit: '2.0 lbs',
    stock: 5,
    image: 'assets/images/products/pineapple.png',
    categoryId: 'cat1',
    isActive: true,
  ),
  Product(
    id: '4',
    categoryName: "",
    name: 'Black Grapes',
    description:
        'Black grapes are small, sweet, and packed with antioxidants. They may have a natural dusty coating but are fresh and delicious.',
    price: 7.0,
    unit: '2.0 lbs',
    stock: 5,
    image: 'assets/images/products/grapes.png',
    categoryId: 'cat1',
    isActive: true,
  ),
  Product(
    id: '5',
    name: 'Pomegranate',
    categoryName: "",
    description:
        'Pomegranates have a tough outer shell with juicy ruby-red seeds inside. They offer a sweet and slightly tart flavor.',
    price: 7.0,
    unit: '2.0 lbs',
    stock: 5,
    image: 'assets/images/products/pomegranate.png',
    categoryId: 'cat1',
    isActive: true,
  ),
  Product(
    id: '6',
    categoryName: "",
    name: 'Fresh Broccoli',
    description:
        'Fresh broccoli is crisp and full of nutrients. Its deep green florets are perfect for steaming, stir-frying, or adding to healthy meals.',
    price: 7.0,
    unit: '2.0 lbs',
    stock: 5,
    image: 'assets/images/products/broccoli.png',
    categoryId: 'cat1',
    isActive: true,
  ),
];

List<CartItem> cartItems = [
  CartItem(
    product: Product(
      id: '1',
      categoryName: "",
      name: 'Fresh Broccoli',
      price: 2.22,
      unit: '1.50 lbs',
      image: 'assets/images/products/broccoli.png',
      description: '',
      stock: 10,
      categoryId: '1',
      isActive: true,
    ),
    quantity: 5,
  ),
  CartItem(
    product: Product(
      id: '2',
      categoryName: "",
      name: 'Black Grapes',
      price: 2.22,
      unit: '5.0 lbs',
      image: 'assets/images/products/grapes.png',
      description: '',
      stock: 10,
      categoryId: '1',
      isActive: true,
    ),
    quantity: 5,
  ),
];

List<Address> addresses = [
  Address(
    fullname: "Russell Austin",
    phoneNumber: "+1 202 555 0142",
    address: "2811 Crescent Day, LA Port",
    city: "California",
    country: "USA",
    isDefault: true,
  ),
  Address(
    fullname: "Jessica Simpson",
    phoneNumber: "+1 202 555 0142",
    address: "2811 Crescent Day, LA Port",
    city: "California",
    country: "USA",
    isDefault: false,
  ),
];
