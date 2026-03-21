import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CategoryFilterModal extends StatelessWidget {
  const CategoryFilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Vegetables',
      'Fruits',
      'Beverages',
      'Grocery',
      'Edible oil',
      'Household',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Thanh nhỏ trang trí trên đầu modal
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Select Category",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          // Danh sách các Category để lọc
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index]),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Xử lý logic lọc tại đây
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
