import 'package:flutter/material.dart';
import 'about_me_screen.dart';
import 'my_address_screen.dart';
import 'my_order_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Avatar & Info
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/avt.png',
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Olivia Austin",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "oliviaaustin@gmail.com",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Menu List
            _buildMenuItem(Icons.person_outline, "About me", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutMeScreen()),
              );
            }),
            _buildMenuItem(Icons.shopping_bag_outlined, "My Orders", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyOrderScreen()),
              );
            }),
            _buildMenuItem(Icons.favorite_border, "My Favorites", () {}),
            _buildMenuItem(Icons.location_on_outlined, "My Address", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyAddressScreen()),
              );
            }),
            _buildMenuItem(Icons.logout, "Sign out", () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
