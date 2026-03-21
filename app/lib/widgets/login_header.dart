import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final String backgroundImagePath;
  const LoginHeader({super.key, required this.backgroundImagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Text(
            'Welcome back',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
