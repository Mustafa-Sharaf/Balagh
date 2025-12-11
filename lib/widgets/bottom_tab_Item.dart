import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/AppColors.dart';
import '../modules/Complaint/Complaint_Screen.dart';
import '../modules/Complaints/Complaints_Screen.dart';
import '../modules/Home/Home_Controller.dart';



class BottomTabItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final BottomNavController controller = Get.find();

  BottomTabItem({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.currentIndex.value == index;
      return GestureDetector(
        onTap: (){
          if (index == 1) {
            //Get.to(() =>  InventoryManagementScreen());
            Get.to(() =>  ComplaintScreen());
          } else if (index == 3) {
           // Get.to(() =>  CartScreen());
          } else if (index == 4) {
           // Get.to(() =>  BillsScreen());
          } else {
            controller.changeTabIndex(index);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              size:MediaQuery.of(context).size.width * 0.06,),
            Text(label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      );
    });
  }
}