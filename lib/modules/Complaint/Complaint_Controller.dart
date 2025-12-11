/*
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'Complaint_Model.dart';
class ViewComplaintController extends GetxController {
  var complaint = Rxn<Complaint>();
  var loading = false.obs;
  var error = RxnString();
  final storage = GetStorage();

  void load(int id) {
    fetchComplaintById(id);
  }

  Future<void> fetchComplaintById(int id) async {
    loading.value = true;
    error.value = null;
    complaint.value = null;

    try {
      final token = storage.read("token");
      final url = "http://balagh.runasp.net/api/Complaints/GetComplaintById/$id";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "accept": "application/json",
        },
      );

      print("STATUS CODE: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        complaint.value = Complaint.fromJson(data);
      } else if (response.statusCode == 401) {
        error.value = "انتهت صلاحية الجلسة — الرجاء تسجيل الدخول من جديد";
      } else if (response.statusCode == 404) {
        error.value = "لم يتم العثور على الشكوى";
      } else {
        error.value = "فشل الطلب — رمز الخطأ ${response.statusCode}";
      }
    } catch (e) {
      error.value = "مشكلة في الاتصال بالسيرفر";
      print("EXCEPTION: $e");
    } finally {
      loading.value = false;
    }
  }
}
*/

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'Complaint_Model.dart';
class ViewComplaintController extends GetxController {
  var complaint = Rxn<Complaint>();
  var loading = false.obs;
  var error = RxnString();

  Future<void> load(int complaintId) async {
    loading.value = true;
    error.value = null;

    try {
      final token = GetStorage().read("token");
      final url = Uri.parse(
          "http://balagh.runasp.net/api/Complaints/GetComplaintById/$complaintId");

      final response = await http.get(
        url,
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $token',
        },
      );
      print("CODE: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        complaint.value = Complaint.fromJson(data);
      } else {
        error.value = "فشل في تحميل الشكوى";
      }
    } catch (e) {
      error.value = "خطأ في الاتصال بالسيرفر";
    }

    loading.value = false;
  }
}
