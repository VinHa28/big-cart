import 'package:app/constants/app_assets.dart';
import 'package:app/models/category.dart';
import 'package:app/models/product.dart';
import 'package:app/screens/product_list_screen.dart';
import 'package:app/services/category_service.dart';
import 'package:app/services/product_service.dart';
import 'package:app/widgets/category_card.dart';
import 'package:app/widgets/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBannerIndex = 0;

  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();

  List<Category> _categories = [];
  List<Product> _products = [];

  final String userId = "69bfa2020213cda8607ee688";

  // 3. Hàm xử lý thêm vào giỏ hàng

  bool _isLoadingCategories = true;
  bool _isLoadingProducts = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadProducts();
  }

  Future<void> _loadCategories() async {
    try {
      final data = await _categoryService.getAllCategories();
      setState(() {
        _categories = data;
        _isLoadingCategories = false;
      });
    } catch (e) {
      print("Error loading categories: $e");
      setState(() {
        _isLoadingCategories = false;
      });
    }
  }

  Future<void> _loadProducts() async {
    try {
      final data = await _productService.getAllProducts();
      setState(() {
        _products = data;
        _isLoadingProducts = false;
      });
    } catch (e) {
      print("Error loading products: $e");
      setState(() {
        _isLoadingProducts = false;
      });
    }
  }

  final List<String> imgList = [
    AppAssets.banner1,
    AppAssets.banner2,
    AppAssets.banner3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // AppBar
            SliverAppBar(
              backgroundColor: AppColors.scaffoldBackground,
              elevation: 0,
              floating: true,
              title: _buildSearchBar(),
              automaticallyImplyLeading: false,
            ),

            // Banner + Category title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBannerSlider(),
                    const SizedBox(height: 20),
                    _buildSectionHeader('Categories', "/categories"),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),

            // Category list
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: _buildCategoryList(),
              ),
            ),

            // Product title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                child: _buildSectionHeader('Featured products', "/categories"),
              ),
            ),

            // Product list
            _buildProductList(),

            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }

  // ================= UI =================

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search keywords..',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String routeName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            Navigator.pushNamed(context, routeName);
          },
        ),
      ],
    );
  }

  Widget _buildBannerSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 190,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.95,
            onPageChanged: (index, reason) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
          ),
          items: imgList.map((item) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                item,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        _buildDotsIndicator(),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(
              _currentBannerIndex == entry.key ? 0.9 : 0.2,
            ),
          ),
        );
      }).toList(),
    );
  }

  // CATEGORY LIST
  Widget _buildCategoryList() {
    if (_isLoadingCategories) {
      return const SizedBox(
        height: 85,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_categories.isEmpty) {
      return const SizedBox(
        height: 85,
        child: Center(child: Text("No categories")),
      );
    }

    return SizedBox(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: _categories[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProductListScreen(category: _categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // PRODUCT LIST
  Widget _buildProductList() {
    if (_isLoadingProducts) {
      return const SliverToBoxAdapter(
        child: SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_products.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text("No products")),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return ProductCard(product: _products[index], onAdd: () {});
        }, childCount: _products.length),
      ),
    );
  }
}
