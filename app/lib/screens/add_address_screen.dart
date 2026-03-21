import 'package:app/constants/app_colors.dart';
import 'package:app/models/address.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  // 1. Tạo Key để quản lý Form
  final _formKey = GlobalKey<FormState>();

  // 2. Các Controller để lấy dữ liệu
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _zipController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  bool _isDefault = false;

  // 3. Hàm xử lý khi nhấn nút Save
  void _submitData() {
    if (_formKey.currentState!.validate()) {
      // Nếu dữ liệu hợp lệ, tạo object Address mới
      final newAddress = Address(
        fullname: _nameController.text,
        phoneNumber: _phoneController.text,
        address: _addressController.text,
        city: _cityController.text,
        country: _countryController.text,
        isDefault: _isDefault,
      );

      // In ra test hoặc gọi API tại đây
      print("Dữ liệu hợp lệ: ${newAddress.fullname}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data...'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Add Address",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey, // Gán key vào Form
          child: Column(
            children: [
              _buildInputField(
                controller: _nameController,
                icon: Icons.person_outline,
                hint: "Full name",
                validator: (value) =>
                    value!.isEmpty ? "Please enter your full name" : null,
              ),
              _buildInputField(
                controller: _emailController,
                icon: Icons.email_outlined,
                hint: "Email address",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) return "Please enter your email";
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value))
                    return "Invalid email";
                  return null;
                },
              ),
              _buildInputField(
                controller: _phoneController,
                icon: Icons.phone_outlined,
                hint: "Phone number",
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.length < 10 ? "Invalid phone number" : null,
              ),
              _buildInputField(
                controller: _addressController,
                icon: Icons.location_on_outlined,
                hint: "Address",
                validator: (value) =>
                    value!.isEmpty ? "Please enter the address" : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: _zipController,
                      icon: Icons.map_outlined,
                      hint: "Zip code",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildInputField(
                      controller: _cityController,
                      icon: Icons.location_city,
                      hint: "City",
                    ),
                  ),
                ],
              ),
              _buildInputField(
                controller: _countryController,
                icon: Icons.public,
                hint: "Country",
              ),

              Row(
                children: [
                  Switch(
                    value: _isDefault,
                    onChanged: (val) => setState(() => _isDefault = val),
                    activeThumbColor: AppColors.primary,
                  ),
                  const Text(
                    "Make default",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _submitData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Add address",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey, size: 20),
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
          ), // Style cho thông báo lỗi
        ),
      ),
    );
  }
}
