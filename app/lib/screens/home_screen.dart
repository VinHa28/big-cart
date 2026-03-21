import 'package:app/constants/app_assets.dart';
import 'package:app/mock/mock_data.dart';
import 'package:app/screens/category_list_screen.dart';
import 'package:app/screens/product_list_screen.dart';
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

  final List<String> imgList = [
    AppAssets.banner1,
    AppAssets.banner2,
    AppAssets.banner3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      // Sử dụng SafeArea để tránh tai thỏ, phần khuyết
      body: SafeArea(
        child: CustomScrollView(
          // Danh sách các slivers (mảnh ghép cuộn)
          slivers: [
            // 1. App Bar cuộn (chứa Search Bar)
            // SliverAppBar(
            //   backgroundColor: AppColors.scaffoldBackground,
            //   elevation: 0,
            //   floating: true, // App bar xuất hiện ngay khi cuộn xuống
            //   pinned: false, // App bar không cố định khi cuộn lên hết
            //   title: _buildSearchBar(),
            //   automaticallyImplyLeading: false, // Ẩn nút back mặc định nếu có
            // ),

            // 2. Banner và Tiêu đề Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBannerSlider(),
                    const SizedBox(height: 20),
                    // Tiêu đề Categories
                    _buildSectionHeader('Categories', "/categories"),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),

            // 3. Danh sách Categories (SliverToBoxAdapter vì là ListView nằm ngang)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20), // Chỉ padding trái
                child: _buildCategoryList(),
              ),
            ),

            // 4. Tiêu đề Featured Products
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                child: _buildSectionHeader('Featured products', "/categories"),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 cột
                  mainAxisSpacing: 15, // Khoảng cách dòng
                  crossAxisSpacing: 15, // Khoảng cách cột
                  childAspectRatio: 0.7, // Tỷ lệ chiều rộng/chiều cao card
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ProductCard(
                      product: dummyProducts[index],
                      onAdd: () {
                        // Logic thêm vào giỏ hàng
                        print("Đã thêm ${dummyProducts[index].name} vào giỏ");
                      },
                    );
                  },
                  childCount: dummyProducts.length, // Số lượng sản phẩm
                ),
              ),
            ),

            // 6. Khoảng trống cuối trang (để không bị che bởi BottomNav)
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }

  // ====================== CÁC HÀM XÂY DỰNG WIDGET (HELPER FUNCTIONS) ======================

  // Widget xây dựng Search Bar
  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search keywords..',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          // Icon lọc ở bên phải
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_list_outlined, color: Colors.grey),
            onPressed: () {},
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  // Widget xây dựng Tiêu đề các mục (với icon >)
  Widget _buildSectionHeader(String title, String routeName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: Colors.grey, size: 28),
          onPressed: () {
            // Bấm vào dấu mũi tên để sang màn hình danh sách Category
            Navigator.pushNamed(context, routeName);
          },
        ),
      ],
    );
  }

  // Widget Banner Slider
  Widget _buildBannerSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 190.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.95, // Tăng lên một chút cho đẹp
            onPageChanged: (index, reason) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
          ),
          items: imgList.map((item) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  // Thêm loading hoặc error builder nếu cần
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        // Dots Indicator
        _buildDotsIndicator(),
      ],
    );
  }

  // Widget Dots Indicator cho Banner
  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () {
            // Không nên setState ở đây vì CarouselSlider không tự chuyển
            // Nếu muốn tap để chuyển banner, cần dùng CarouselController
          },
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(
                _currentBannerIndex == entry.key ? 0.9 : 0.2,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // Widget Category List (ListView nằm ngang)
  Widget _buildCategoryList() {
    return SizedBox(
      height: 80, // Tăng nhẹ chiều cao
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dummyCategories.length,
        itemBuilder: (context, index) {
          // Thêm padding phải cho từng card trừ card cuối
          return Padding(
            padding: EdgeInsets.only(
              right: index == dummyCategories.length - 1 ? 20.0 : 0.0,
            ),
            child: CategoryCard(
              category: dummyCategories[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductListScreen(category: dummyCategories[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
