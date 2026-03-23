import 'package:app/constants/app_colors.dart';
import 'package:app/models/address.dart';
import 'package:app/services/address_service.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final AddressService _addressService = AddressService();
  final String userId = "69bfa2020213cda8607ee688";

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController(text: "Vietnam");

  bool _isDefault = false;
  bool _isSubmitting = false;

  void _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      final newAddress = Address(
        fullname: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        country: _countryController.text.trim(),
        isDefault: _isDefault,
      );

      try {
        await _addressService.createAddress(userId, newAddress);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Lưu địa chỉ thành công!")),
          );
          Navigator.pop(context); // Quay lại MyAddressScreen
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Lỗi: Không thể lưu địa chỉ")),
          );
        }
      } finally {
        if (mounted) setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add New Address",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildInputField(
                controller: _nameController,
                icon: Icons.person_outline,
                hint: "Full Name",
              ),
              _buildInputField(
                controller: _phoneController,
                icon: Icons.phone_outlined,
                hint: "Phone Number",
                keyboardType: TextInputType.phone,
              ),
              _buildInputField(
                controller: _addressController,
                icon: Icons.map_outlined,
                hint: "Street Address (House No, Building)",
              ),
              _buildInputField(
                controller: _cityController,
                icon: Icons.location_city_outlined,
                hint: "City",
              ),
              _buildInputField(
                controller: _countryController,
                icon: Icons.public,
                hint: "Country",
              ),

              const SizedBox(height: 10),
              SwitchListTile(
                title: const Text(
                  "Set as default address",
                  style: TextStyle(fontSize: 14),
                ),
                value: _isDefault,
                activeColor: AppColors.primary,
                onChanged: (val) => setState(() => _isDefault = val),
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Save Address",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (v) =>
            (v == null || v.isEmpty) ? "Vui lòng nhập thông tin" : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
