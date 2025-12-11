import 'package:flutter/material.dart';
import '../../../app_theme/AppColors.dart';

class SignInBackground extends StatelessWidget {
  const SignInBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedDirectional(
          top: -120,
          start: -100, // بدل left
          child: _circle(325, AppColors.primaryColor),
        ),
        PositionedDirectional(
          top: 40,
          start: 70,
          child: _circle(175, AppColors.primaryColor),
        ),
        PositionedDirectional(
          top: 185,
          start: 170,
          child: Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/Balagh1.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: -200,
          end: -150,
          child: _circle(300, AppColors.primaryColor),
        ),
        PositionedDirectional(
          bottom: -190,
         end: -140,
          child: _circle(300, const Color(0x7314B8A6)),
        ),
      ],
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
