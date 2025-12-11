import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/AppColors.dart';
import '../app_theme/theme_controller.dart';

InputDecoration inputDecoration(String label) {
  final ThemeController themeController = Get.find();
  return InputDecoration(
    labelText: label,
    filled: true,
    fillColor:themeController.isDarkMode.value?AppColors.componentDark : AppColors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.primaryColor,
        width: 2,
      ),
    ),

    floatingLabelStyle: TextStyle(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
    ),
  );
}