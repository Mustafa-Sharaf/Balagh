import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'Submit_Report_Model.dart';


class ComplaintController extends GetxController {
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final loading = false.obs;
  RxList<File> files = <File>[].obs;
  RxList<GovernmentalEntity> governmentalEntities = <GovernmentalEntity>[].obs;
  RxBool loadingEntities = false.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchGovernmentalEntities();
  }

  Future<void> fetchGovernmentalEntities() async {
    try {
      loadingEntities.value = true;
      final response = await http.get(
        Uri.parse("http://balagh.runasp.net/api/govermentalEntities"),
      );
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        governmentalEntities.value =
            data.map((e) => GovernmentalEntity.fromJson(e)).toList();
      } else {
        Get.snackbar(
            "Error",
            "Government agencies failed to load",
            colorText: Colors.white,
            backgroundColor:Colors.red
        );
      }
    } catch (e) {
      Get.snackbar(
          "Error",
          "Unable to connect to the server",
          colorText: Colors.white,
          backgroundColor:Colors.red
      );
    } finally {
      loadingEntities.value = false;
    }
  }

  Future<bool> createComplaint({required int governmentalId}) async {
    if (files.isEmpty) {
      Get.snackbar(
          "Error",
          "Please attach at least one file",
          colorText: Colors.white,
          backgroundColor: Colors.red,
            );
      return false;
    }

    try {
      loading.value = true;
      final token = storage.read("token");
      //print("token====================$token");
      if (token == null) {
        loading.value = false;
        print("No login");
        Get.snackbar(
            "Error",
            "No login",
            colorText: Colors.white,
            backgroundColor:Colors.red);
        return false;
      }
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://balagh.runasp.net/api/Complaints/CreateComplaint"),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.fields.addAll({
        "governmentalEntityId": governmentalId.toString(),
        "location": locationController.text,
        "description": descriptionController.text,
      });

      for (var file in files) {
        final bytes = await file.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            "complaintFiles",
            bytes,
            filename: file.path.split("/").last,
          ),
        );
      }

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      loading.value = false;

     // print("HTTP STATUS: ${response.statusCode}");
     // print("Response body: $respStr");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
            "Success",
            "The report was successfully submitted",
            colorText: Colors.white,
            backgroundColor:Colors.green);
        files.clear();
        locationController.clear();
        descriptionController.clear();
        return true;
      }
      print("Report failed to send: $respStr");
      Get.snackbar(
          "Error",
          "Report failed to send",
          colorText: Colors.white,
          backgroundColor:Colors.red);
      return false;
    } catch (e) {
      loading.value = false;
      print("An error occurred during transmission: $e");
      Get.snackbar(
          "error",
          "An error occurred during transmission",
          colorText: Colors.white,
          backgroundColor:Colors.red,
      );
      return false;
    }
  }

}
