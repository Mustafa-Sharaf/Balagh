import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/theme_controller.dart';
import '../../widgets/CustomTextField.dart';
import '../../app_theme/AppColors.dart';
import '../../widgets/SignInBackground.dart';
import 'SignIn_Controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    final ThemeController themeController = Get.find();
    return Scaffold(
      backgroundColor: themeController.isDarkMode.value?AppColors.backgroundDark : AppColors.white,
      body: Stack(
        children: [
          const SignInBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "WelcomeBack".tr,
                    style: TextStyle(fontSize: 22, color: themeController.isDarkMode.value?AppColors.black : AppColors.white),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: Text(
                    "LogIn".tr,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: themeController.isDarkMode.value?AppColors.black : AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 150),
                CustomTextField(
                  label: "EmailAddress".tr,
                  icon: Icons.email_outlined,
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextField(
                  label: "Password".tr,
                  icon: Icons.lock_outline,
                  obscureText: true,
                  controller: controller.passwordController,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "ForgotPassword".tr,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      onPressed: controller.login,
                      child: Text(
                        "Log_In".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("Don’tHaveAnAccount".tr),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/signUp');
                      },
                      child: Text(
                        "Sign_Up".tr,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
