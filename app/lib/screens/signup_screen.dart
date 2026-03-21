import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/login_header.dart';
import 'login_screen.dart'; // Import màn hình Login để điều hướng

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Chỉ còn State này, không cần state cho ô mật khẩu
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gọi Header với ảnh nền của màn Đăng ký
            const LoginHeader(backgroundImagePath: AppAssets.signupBackground),

            // Phần Form
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề mới
                  const Text(
                    'Create account',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  // Phụ đề mới
                  const Text(
                    'Quickly create account',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 15),

                  // Ô nhập 1: Email (Tái sử dụng)
                  const CustomTextField(
                    hintText: 'Email address',
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 15),

                  // Ô nhập 2: Phone number (MỚI)
                  const CustomTextField(
                    hintText: 'Phone number',
                    icon: Icons.phone_outlined,
                  ),
                  const SizedBox(height: 15),

                  // Ô nhập 3: Password (Tái sử dụng)
                  CustomTextField(
                    hintText: '● ● ● ● ● ● ● ●',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    isObscure: _isObscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),

                  // Màn hình này không có "Remember me" và "Forgot Password"
                  // Bỏ đoạn code đó đi và thay bằng khoảng cách
                  const SizedBox(height: 20),

                  // Nút Đăng ký (Signup Button)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6CC51D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Dòng văn bản điều hướng về Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Điều hướng quay về màn Login
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
