import 'package:app/constants/app_colors.dart';
import 'package:app/models/address.dart';
import 'package:app/services/address_service.dart';
import 'package:flutter/material.dart';
import 'add_address_screen.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final AddressService _addressService = AddressService();
  final String userId = "69bfa2020213cda8607ee688";

  List<Address> _addresses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  // Lấy danh sách địa chỉ từ API
  Future<void> _fetchAddresses() async {
    try {
      setState(() => _isLoading = true);
      final data = await _addressService.getAllAddresses(userId);
      setState(() {
        _addresses = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar("Lỗi khi tải danh sách địa chỉ");
    }
  }

  // Thiết lập mặc định
  void _handleSetDefault(String? addressId) async {
    if (addressId == null) return;
    try {
      final updatedList = await _addressService.setDefault(userId, addressId);
      setState(() => _addresses = updatedList);
      _showSnackBar("Đã thay đổi địa chỉ mặc định");
    } catch (e) {
      _showSnackBar("Không thể cập nhật địa chỉ mặc định");
    }
  }

  // Xóa địa chỉ
  void _handleDelete(String? addressId) async {
    if (addressId == null) return;
    try {
      final updatedList = await _addressService.deleteAddress(
        userId,
        addressId,
      );
      setState(() => _addresses = updatedList);
      _showSnackBar("Đã xóa địa chỉ");
    } catch (e) {
      _showSnackBar("Lỗi khi xóa địa chỉ");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Address",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : RefreshIndicator(
              onRefresh: _fetchAddresses,
              child: _addresses.isEmpty
                  ? const Center(
                      child: Text("Chưa có địa chỉ nào. Vui lòng thêm mới!"),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: _addresses.length,
                      itemBuilder: (context, index) =>
                          _buildAddressItem(_addresses[index]),
                    ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddAddressScreen()),
              );
              _fetchAddresses(); // Tải lại sau khi quay về
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Add New Address",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressItem(Address addr) {
    // Ép kiểu dynamic để lấy ID từ MongoDB nếu Model chưa định nghĩa rõ
    final String? addrId = (addr as dynamic).id;

    return Dismissible(
      key: Key(addrId ?? addr.fullname),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async => await _confirmDelete(),
      onDismissed: (_) => _handleDelete(addrId),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () => _handleSetDefault(addrId),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: addr.isDefault
                ? Border.all(color: AppColors.primary, width: 1.5)
                : null,
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: addr.isDefault ? AppColors.primary : Colors.grey,
                size: 28,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addr.fullname,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${addr.address}, ${addr.city}",
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Text(
                      addr.phoneNumber,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(
                addr.isDefault
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: addr.isDefault ? AppColors.primary : Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận"),
        content: const Text("Bạn có chắc chắn muốn xóa địa chỉ này?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Hủy"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Xóa", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
