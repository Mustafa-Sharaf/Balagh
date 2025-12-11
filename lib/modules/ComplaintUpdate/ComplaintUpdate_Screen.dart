import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/AppColors.dart';
import '../../app_theme/theme_controller.dart';
import '../../widgets/InputDecoration.dart';
import '../Submit_Report/Submit_Report_Controller.dart';
import 'ComplaintUpdate_Controller.dart';
import 'ComplaintUpdate_Model.dart';

class EditComplaintScreen extends StatelessWidget {
  final int complaintId;
  final int governmentalEntityId;
  final String oldLocation;
  final String oldDescription;
  final String rowVersion;

  final controller = Get.put(UpdateComplaintController());
  final governmentalId = Rxn<int>();

  EditComplaintScreen({
    super.key,
    required this.complaintId,
    required this.governmentalEntityId,
    required this.oldLocation,
    required this.oldDescription,
    required this.rowVersion,
  });

  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    locationController.text = oldLocation;
    descriptionController.text = oldDescription;
    final themeController = Get.find<ThemeController>();
    final controller1 = Get.find<ComplaintController>();

    return Scaffold(
      //backgroundColor: const Color(0xfff4f6fa),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          "EditComplaint".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 6,
                shadowColor: AppColors.primaryColor.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "GovernmentAgency".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: themeController.isDarkMode.value
                              ? AppColors.componentDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              if (controller1.loadingEntities.value) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                );
                              }
                              return DropdownButtonFormField<int>(
                                value: governmentalId.value,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: themeController.isDarkMode.value
                                      ? AppColors.componentDark
                                      : Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(color: themeController.isDarkMode.value?AppColors.white :Colors.black87,),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(14),
                                items: controller1.governmentalEntities.map((entity) {
                                  return DropdownMenuItem(
                                    value: entity.id,
                                    child: Text(entity.name),
                                  );
                                }).toList(),
                                onChanged: (v) => governmentalId.value = v,
                              );
                              ;
                            }),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          Text(
                            "Location".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: themeController.isDarkMode.value?AppColors.componentDark :Colors.white,
                          hintText: "EnterTheComplaintWebsite".tr,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            "Description".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: descriptionController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: themeController.isDarkMode.value?AppColors.componentDark :Colors.white,
                          hintText: "EnterDescriptionComplaint".tr,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () async {
                  final model = ComplaintUpdateModel(
                    governmentalEntityId: governmentalEntityId,
                    location: locationController.text,
                    description: descriptionController.text,
                    newStatus: "New",
                    rowVersion: rowVersion,
                  );

                  final success = await controller.updateComplaint(
                    complaintId,
                    model,
                  );

                  if (success) {
                    Get.back(result: true);
                    Get.snackbar(
                      "success",
                      "The complaint was successfully amended",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                    );
                  } else {
                    Get.snackbar(
                      "Error",
                      controller.error.value,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                    );
                  }
                },
                child:Text(
                  "SaveUpdate".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
