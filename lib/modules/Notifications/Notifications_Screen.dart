

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/AppColors.dart';



import '../../widgets/notificationCard.dart';
import 'Notifications_Controller.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications".tr),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return Center(
            child: Text(
              "NoNotifications".tr,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          itemBuilder: (_, index) {
            final group = controller.notifications[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    formatDate(group.createdAt),
                    style: TextStyle(
                      fontSize: 15,
                      //fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ...group.notifications.map(
                      (n) => NotificationCard(notification: n),
                ),
              ],
            );
          },
        );
      }),
    );
  }

  String formatDate(String date) {
    final d = DateTime.parse(date);
    return "${d.day}-${d.month}-${d.year}";
  }
}
