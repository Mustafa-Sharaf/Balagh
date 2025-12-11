import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/AppColors.dart';
import '../../app_theme/theme_controller.dart';
import '../../widgets/bottom_tab_Item.dart';
import '../Complaints/Complaints_Screen.dart';
import '../Profile/Profile_Screen.dart';
import '../Submit_Report/Submit_Report_Screen.dart';
import 'Home_Controller.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final BottomNavController controller = Get.put(BottomNavController());
  final List<Widget> pages = [
    SubmitReportScreen(),
    ComplaintScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      backgroundColor: themeController.isDarkMode.value?AppColors.E : AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        actions: [
          Text(
            "Home_Screen".tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.055,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.25),
          IconButton(
            icon: const Text('🔎', style: TextStyle(fontSize: 25)),
            onPressed: () => {},
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          IconButton(
            icon: const Text('🔔', style: TextStyle(fontSize: 20)),
            onPressed: () => Get.toNamed('/notificationsScreen'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        ],

      ),
      body: Obx(
        () =>
            IndexedStack(index: controller.currentIndex.value, children: pages),
      ),

      floatingActionButton: Transform.translate(
        offset: const Offset(0, 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.14,
          width: MediaQuery.of(context).size.width * 0.14,
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            elevation: 8,
            shape: const CircleBorder(),
            onPressed: () async {
              Get.toNamed('/profile');
            },
            child: const Icon(Icons.person, size: 35, color: Colors.grey),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.0805,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: BottomTabItem(
                  index: 0,
                  icon: Icons.report,
                  label: 'SubmitReport'.tr,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.4),
              Expanded(
                child: BottomTabItem(
                  index:1,
                  icon: Icons.view_list,
                  label: 'ViewReports'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
