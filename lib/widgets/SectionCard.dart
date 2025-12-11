import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/AppColors.dart';
import '../app_theme/theme_controller.dart';


class SectionCard extends StatelessWidget {
  final IconData icon;
  final String  title;
  final String content;

  const SectionCard({super.key,required this.icon,required this.title,required this.content});


  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: themeController.isDarkMode.value?AppColors.componentDark :Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 26),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: themeController.isDarkMode.value?AppColors.white : Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                      fontSize: 15,
                      color:themeController.isDarkMode.value?Colors.grey[500] : Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
