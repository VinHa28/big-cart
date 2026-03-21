import 'package:flutter/material.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About me"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Personal Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 15),
            _buildTextField(Icons.person_outline, "Russell Austin"),
            _buildTextField(Icons.email_outlined, "russell.partner@gmail.com"),
            _buildTextField(Icons.phone_outlined, "+1 202 555 0142"),
            const SizedBox(height: 30),
            const Text(
              "Change Password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 15),
            _buildTextField(
              Icons.lock_outline,
              "Current password",
              isPassword: true,
            ),
            _buildTextField(
              Icons.lock_outline,
              "New password",
              isPassword: true,
              hasVisibility: true,
            ),
            _buildTextField(
              Icons.lock_outline,
              "Confirm password",
              isPassword: true,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  "Save settings",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    IconData icon,
    String hint, {
    bool isPassword = false,
    bool hasVisibility = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.grey),
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: hasVisibility
              ? const Icon(Icons.visibility_outlined)
              : null,
        ),
      ),
    );
  }
}
