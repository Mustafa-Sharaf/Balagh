import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/AppColors.dart';
import '../../app_theme/theme_controller.dart';
import '../../widgets/SectionCard.dart';
import '../ComplaintUpdate/ComplaintUpdate_Screen.dart';
import 'Complaint_Controller.dart';

class ComplaintDetailsScreen extends StatelessWidget {
  final int complaintId;
  final int displayNumber;
  final controller = Get.put(ViewComplaintController());

  ComplaintDetailsScreen({
    super.key,
    required this.complaintId,
    required this.displayNumber,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.load(complaintId);
    });
  }

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

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "inprocessing":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: theme.isDarkMode.value ? AppColors.E : Color(0xfff5f7fb),
      appBar: AppBar(
        title: Text(
          "DetailsComplaint".tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_calendar_sharp, color: Colors.white,size: 30,),
            onPressed: () async {
              final c = controller.complaint.value!;
              final result = await Get.to(() => EditComplaintScreen(
                complaintId: complaintId,
                governmentalEntityId: c.governmentalEntityId,
                oldLocation: c.location,
                oldDescription: c.description,
                rowVersion: c.rowVersion,
              ));

              if (result == true) {
                controller.load(complaintId);
              }
            },
          ),
          SizedBox(width: 30,)
        ],

        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        if (controller.error.value != null) {
          return Center(
            child: Text(
              controller.error.value!,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
        if (controller.complaint.value == null) {
          return Center(child: Text("NoDataAvailable".tr));
        }
        final c = controller.complaint.value!;
        return ListView(
          padding: EdgeInsets.all(16),
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.white, size: 30),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "ComplaintNumber".trParams({
                        "number": displayNumber.toString(),
                      }),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      c.status,
                      style: TextStyle(
                        color: getStatusColor(c.status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),
            SectionCard(
              icon: Icons.account_balance,
              title: "TheConcernedParty".tr,
              content: ministries[c.governmentalEntityId] ?? "unknown",
            ),
            SectionCard(
              icon: Icons.location_on,
              title: "ComplaintSite".tr,
              content: c.location,
            ),
            SectionCard(
              icon: Icons.description_outlined,
              title: "Description".tr,
              content: c.description,
            ),
            SizedBox(height: 25),
            Text(
              "Attachments".tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            c.files.isEmpty
                ? Center(child: Text("NoAttachments".tr))
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemCount: c.files.length,
                    itemBuilder: (context, index) {
                      final file = c.files[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(file, fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
          ],
        );
      }),
    );
  }
}
