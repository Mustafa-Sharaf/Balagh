import 'dart:io';
import 'package:balagh/app_theme/AppColors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/theme_controller.dart';
import '../../widgets/Card.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/InputDecoration.dart';
import 'Submit_Report_Controller.dart';

class SubmitReportScreen extends StatelessWidget {
  SubmitReportScreen({super.key});
  final controller = Get.put(ComplaintController());
  final governmentalId = Rxn<int>();



  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      backgroundColor: themeController.isDarkMode.value
          ? AppColors.E
          : AppColors.backgroundColor,
      body: Obx(() {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Text(
                    "GovernmentAgencyInformation".tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  card(
                    Obx(() {
                      if (controller.loadingEntities.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }
                      return DropdownButtonFormField<int>(
                        value: governmentalId.value,
                        decoration: inputDecoration("GovernmentAgency".tr),
                        items: controller.governmentalEntities.map((entity) {
                          return DropdownMenuItem(
                            value: entity.id,
                            child: Text(entity.name),
                          );
                        }).toList(),
                        onChanged: (v) => governmentalId.value = v,
                      );
                    }),
                    color: themeController.isDarkMode.value
                        ? Colors.grey.shade800
                        : Colors.white,
                  ),

                  const SizedBox(height: 22),
                  Text(
                    "ReportDetails".tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  card(
                    Column(
                      children: [
                        CustomTextField(
                          label: "Location".tr,
                          controller: controller.locationController,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          label: "DescriptionOfTherePort".tr,
                          controller: controller.descriptionController,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final picked = await FilePicker.platform.pickFiles(
                              allowMultiple: true,
                            );
                            if (picked != null) {
                              for (var file in picked.files) {
                                controller.files.add(File(file.path!));
                              }
                              Get.snackbar(
                                "تم",
                                "تم إضافة ${picked.files.length} ملف",
                                colorText: Colors.white,
                                backgroundColor: Colors.green
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.upload_rounded,
                            color: Colors.white,
                          ),
                          label: Text(
                            "AttachFiles".tr,
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 14),
                        if (controller.files.isNotEmpty)
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: controller.files.map((f) {
                              return Chip(
                                backgroundColor: Colors.grey.shade200,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                label: Text(
                                  f.path.split("/").last,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                avatar: const Icon(Icons.attach_file, size: 18),
                                deleteIcon: const Icon(Icons.close, size: 18),
                                onDeleted: () {
                                  controller.files.remove(f);
                                },
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                    color: themeController.isDarkMode.value
                        ? Colors.grey.shade800
                        : Colors.white,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: themeController.isDarkMode.value
                    ? Colors.grey.shade800
                    : Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.loading.value
                        ? null
                        : () async {
                            if (governmentalId.value == null ||
                                controller.locationController.text.isEmpty ||
                                controller.descriptionController.text.isEmpty) {
                              Get.snackbar(
                                   "Alert".tr,
                                   "PleaseFillInAllFields".tr,
                                   colorText: Colors.white,
                                   backgroundColor: Colors.red
                              );
                              return;
                            }

                            await controller.createComplaint(
                              governmentalId: governmentalId.value!,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.loading.value
                        ?  CircularProgressIndicator(color:AppColors.primaryColor)
                        : Text(
                            "SendTheReport".tr,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

/*  card(
                    DropdownButtonFormField<int>(
                      value: governmentalId.value,
                      decoration: inputDecoration("GovernmentAgency".tr),
                      items: const [
                        DropdownMenuItem(value: 1, child: Text("وزارة التربية والتعليم")),
                        DropdownMenuItem(value: 2, child: Text("وزارة الصحة")),
                        DropdownMenuItem(value: 3, child: Text("وزارة المالية")),
                        DropdownMenuItem(value: 4, child: Text("وزارة الداخلية")),
                        DropdownMenuItem(value: 5, child: Text("وزارة العدل")),
                        DropdownMenuItem(value: 6, child: Text("وزارة الشؤون الاجتماعية والعمل")),
                        DropdownMenuItem(value: 7, child: Text("وزارة النقل")),
                        DropdownMenuItem(value: 8, child: Text("وزارة السياحة")),
                        DropdownMenuItem(value: 9, child: Text("وزارة الزراعة والإصلاح الزراعي")),
                        DropdownMenuItem(value: 10, child: Text("وزارة الصناعة")),
                        DropdownMenuItem(value: 11, child: Text("وزارة الاقتصاد والصناعة")),
                        DropdownMenuItem(value: 12, child: Text("وزارة الثقافة")),
                        DropdownMenuItem(value: 13, child: Text("وزارة الإعلام")),
                        DropdownMenuItem(value: 14, child: Text("وزارة الإتصالات وتقانة المعلومات")),
                        DropdownMenuItem(value: 15, child: Text("وزارة الأشغال العامة والإسكان")),
                        DropdownMenuItem(value: 16, child: Text("وزارة الطاقة")),
                        DropdownMenuItem(value: 17, child: Text("وزارة الإدارة المحلية والبيئة")),
                        DropdownMenuItem(value: 18, child: Text("وزارة النقل والمواصلات")),
                        DropdownMenuItem(value: 19, child: Text("وزارة السياحة والآثار")),
                        DropdownMenuItem(value: 20, child: Text("وزارة التعليم العالي والبحث العلمي")),
                        DropdownMenuItem(value: 21, child: Text("وزارة الشباب والرياضة")),
                        DropdownMenuItem(value: 22, child: Text(" التنمية الإدارية")),
                        DropdownMenuItem(value: 23, child: Text("وزارة الطوارئ والكوارث"))
                      ],
                      onChanged: (v) => governmentalId.value = v,
                    ),
                      color: themeController.isDarkMode.value? Colors.grey.shade800 : Colors.white
                  ),*/
