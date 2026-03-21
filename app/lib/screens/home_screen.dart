import 'package:app/constants/app_assets.dart';
import 'package:app/mock/mock_data.dart';
import 'package:app/widgets/category_card.dart';
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
      // Sử dụng CustomScrollView để thanh Search Bar có thể cuộn lên
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.scaffoldBackground,
              elevation: 0,
              floating: true,
              pinned: false,
              title: _buildSearchBar(),
            ),

            // Phần nội dung chính
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBannerSlider(),
                    const SizedBox(height: 20),
                    // Tiêu đề Categories
                    _buildSectionHeader('Categories'),
                    const SizedBox(height: 15),
                    // Category List
                    SizedBox(
                      height: 78,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dummyCategories.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            category: dummyCategories[index],
                            onTap: () {
                              print("Selected: ${dummyCategories[index].name}");
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tiêu đề Featured Products
                    _buildSectionHeader('Featured products'),
                    const SizedBox(height: 15),
                    // ... (Phần Product Grid sẽ được thêm vào đây sau)
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget xây dựng Search Bar
  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
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
  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Icon(Icons.chevron_right, color: Colors.grey, size: 28),
      ],
    );
  }

  Widget _buildBannerSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 190.0, // Chiều cao của banner
            autoPlay: true, // Tự động chuyển banner
            enlargeCenterPage: true, // Hiệu ứng phóng to banner ở giữa
            aspectRatio: 16 / 9, // Tỷ lệ khung hình
            viewportFraction:
                0.92, // Độ rộng của mỗi banner so với màn hình (để lộ lề)
            onPageChanged: (index, reason) {
              // Cập nhật State khi banner thay đổi để vẽ lại dots indicator
              setState(() {
                _currentBannerIndex = index;
              });
            },
          ),
          // Duyệt qua danh sách ảnh để tạo ra các widget ảnh
          items: imgList
              .map(
                (item) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0), // Bo góc ảnh
                    child: Image.asset(item, fit: BoxFit.cover, width: 1000),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 10),
        // Dấu chấm tròn chỉ số trang (Dots Indicator)
        _buildDotsIndicator(),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _currentBannerIndex = entry.key,
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Màu xanh lá nếu đang chọn, màu xám nếu không chọn
              color: AppColors.primary.withOpacity(
                _currentBannerIndex == entry.key ? 0.9 : 0.2,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
