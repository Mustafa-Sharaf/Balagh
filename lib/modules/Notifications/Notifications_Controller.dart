import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'package:balagh/modules/notifications/notifications_model.dart';


class NotificationsController extends GetxController {
  var isLoading = false.obs;
  var notifications = <NotificationsModel>[].obs;

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  Future<void> fetchNotifications() async {
    isLoading(true);
    final token = GetStorage().read("token");
    final response = await HttpHelper.getRequest(
      endpoint: "users/notifications",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response["success"] == true) {
      var data = response["data"]; // هذا هو الليست مباشرة

      notifications.value = (data as List)
          .map((e) => NotificationsModel.fromJson(e))
          .toList();
    } else {
      notifications.clear();
    }

    isLoading(false);
  }
}
