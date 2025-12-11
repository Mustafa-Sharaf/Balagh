import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/AppColors.dart';
import '../../app_theme/theme_controller.dart';
import '../Complaint/Complaint_Screen.dart';
import 'Complaints_Controller.dart';
import 'Complaints_Model.dart';

class ComplaintScreen extends StatelessWidget {
  final controller = Get.put(ComplaintsController());

  final Map<int, String> ministries = {
    1: "وزارة التربية والتعليم",
    2: "وزارة الصحة",
    3: "وزارة المالية",
    4: "وزارة الداخلية",
    5: "وزارة العدل",
    6: "وزارة الشؤون الاجتماعية والعمل",
    7: "وزارة النقل",
    8: "وزارة السياحة",
    9: "وزارة الزراعة والإصلاح الزراعي",
    10: "وزارة الصناعة",
    11: "وزارة الاقتصاد والصناعة",
    12: "وزارة الثقافة",
    13: "وزارة الإعلام",
    14: "وزارة الإتصالات وتقانة المعلومات",
    15: "وزارة الأشغال العامة والإسكان",
    16: "وزارة الطاقة",
    17: "وزارة الإدارة المحلية والبيئة",
    18: "وزارة النقل والمواصلات",
    19: "وزارة السياحة والآثار",
    20: "وزارة التعليم العالي والبحث العلمي",
    21: "وزارة الشباب والرياضة",
    22: "التنمية الإدارية",
    23: "وزارة الطوارئ والكوارث",
  };

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.orange;
      case 'done':
        return Colors.green;
      case 'in progress':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("ViewComplaints".tr),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                itemCount: controller.complaints.length,
                itemBuilder: (context, index) {
                  ComplaintModel complaint = controller.complaints[index];
                  int displayNumber =
                      (controller.pageNumber.value - 1) * controller.pageSize + index + 1;
                  return GestureDetector(
                      onTap: () {
                    Get.to(() => ComplaintDetailsScreen(complaintId: complaint.id,displayNumber: displayNumber,));
                  },
                  child:Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: themeController.isDarkMode.value?AppColors.componentDark : AppColors.white
                    /*    gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey.shade100],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),*/
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
                                '$displayNumber',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ministries[complaint.governmentalEntityId] ??
                                      'غير محدد',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        complaint.location,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:themeController.isDarkMode.value?AppColors.white :  Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 4),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor(complaint.status),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        complaint.status,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(top: 18, right: 10),
                            child: Text('📢', style: TextStyle(fontSize: 26)),
                          ),
                        ],
                      ),
                    ),
                  ));
                },
              ),
            ),
            // Pagination Buttons
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              color: themeController.isDarkMode.value?AppColors.E :Colors.grey.shade200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: controller.previousPage,
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    label: Text(
                      'PreviousPage'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    'Page ${controller.pageNumber.value} From ${controller.totalPages.value}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:themeController.isDarkMode.value?AppColors.white :  Colors.black87,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: controller.nextPage,
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    label: Text(
                      'NextPage'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
