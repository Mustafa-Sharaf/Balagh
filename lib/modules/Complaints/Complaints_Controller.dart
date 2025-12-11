import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'Complaints_Model.dart';


class ComplaintsController extends GetxController {
  var complaints = <ComplaintModel>[].obs;
  var pageNumber = 1.obs;
  var totalPages = 1.obs;
  var isLoading = false.obs;

  final int pageSize = 6;
  final storage = GetStorage();

  Future<void> fetchComplaints({int page = 1}) async {
    isLoading.value = true;
    final url = Uri.parse(
        'http://balagh.runasp.net/api/Complaints/GetAllComplaints?pageNum=$page&pageSize=$pageSize'
    );
    final token = storage.read("token");
    final response = await http.get(
      url,
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List items = data['items'];
      complaints.value = items.map((e) => ComplaintModel.fromJson(e)).toList();
      pageNumber.value = data['pageNumber'];
      totalPages.value = data['totalPages'];
    } else {
      Get.snackbar(
          'Error',
          'Failed to load complaints',
          backgroundColor: Colors.red,
          colorText: Colors.white,
      );
    }

    isLoading.value = false;
  }

  void nextPage() {
    if (pageNumber.value < totalPages.value) {
      fetchComplaints(page: pageNumber.value + 1);
    }
  }

  void previousPage() {
    if (pageNumber.value > 1) {
      fetchComplaints(page: pageNumber.value - 1);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchComplaints(page: 1);
  }
}
