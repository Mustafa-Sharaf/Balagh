import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'ComplaintUpdate_Model.dart';

class UpdateComplaintController extends GetxController {
  var loading = false.obs;
  var error = "".obs;

  Future<bool> updateComplaint(
      int id,
      ComplaintUpdateModel model,
      ) async {
    loading.value = true;
    error.value = "";

    final url = "http://balagh.runasp.net/api/Complaints/UpdateComplaint/$id";

    try {
      final token = GetStorage().read("token");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "accept": "text/plain",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        loading.value = false;
        return true;
      } else {
        error.value = "Error: ${response.body}";
        loading.value = false;
        return false;
      }
    } catch (e) {
      loading.value = false;
      error.value = e.toString();
      return false;
    }
  }
}
