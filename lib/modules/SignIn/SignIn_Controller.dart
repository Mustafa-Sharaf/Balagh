import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'SignIn_Model.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loading = false.obs;

  final storage = GetStorage();

  void login() async {
    String fcmToken = GetStorage().read('fcm_token')??"";
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    loading.value = true;
    //print("email: $email");
    //print("password: $password");
    //print("fcmToken: $fcmToken");

    final userLogin = UserLoginModel(
      email: email,
      password: password,
      deviceToken: fcmToken ,
    );

    try {
      final response = await HttpHelper.postRequest(
        endpoint: "users/login",
        body: userLogin.toJson(),
      );
      loading.value = false;

      if (response["success"] == true) {
        final token = response["data"]["token"];
        await storage.write("token", token);

        Get.snackbar(
          "Success",
          "Logged in successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offNamed('/home');
      } else {
        String errorMsg = "";
        if (response["data"] != null && response["data"] is List) {
          List errors = response["data"];
          errorMsg = errors.map((e) => e["description"]).join("\n");
        } else if (response["message"] != null &&
            response["message"].toString().isNotEmpty) {
          errorMsg = response["message"].toString();
        } else {
          errorMsg = "Server returned an error";
        }

        Get.snackbar(
          "Error",
          errorMsg,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar(
        "Error",
        "An error occurred: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
