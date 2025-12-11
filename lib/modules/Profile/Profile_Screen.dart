import 'package:balagh/app_theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_theme/theme_controller.dart';
import '../../widgets/LanguageBottomSheet.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isDarkMode.value?AppColors.E: AppColors.white,
        appBar: AppBar(
          title: Text("Profile".tr),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 80),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.green,
                          Colors.orange,
                          Colors.purple,
                          Colors.red,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/Profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Mustafa Sharaf",
                    style: GoogleFonts.cairo(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: themeController.isDarkMode.value?AppColors.white : AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "mustafa@gmail.com",
                    style: GoogleFonts.cairo(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "0996238054",
                    style: GoogleFonts.cairo(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 35),
                  Divider(),
                  ProfileItem(
                    icon: Icons.language,
                    title: "LanguageEditing".tr,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        builder: (_) => LanguageBottomSheet(),
                      );
                    },

                  ),
                  ProfileItem(
                    icon: Icons.color_lens,
                    title: "discoloration".tr,
                    onTap: () => themeController.toggleTheme(),
                  ),

                  const SizedBox(height: 10),
                  Obx(() => AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                      key: ValueKey(themeController.isDarkMode.value),
                      size: 45,
                      color: themeController.isDarkMode.value
                          ? Colors.yellow
                          : AppColors.primaryColor,
                    ),
                  ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 25),
      leading: Icon(icon, size: 30, color: AppColors.primaryColor),
      title: Text(
        title,
        style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      onTap: onTap,
    );
  }
}
