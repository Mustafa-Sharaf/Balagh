import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Profile_Model.dart';

class ProfileController extends GetxController {
  final storage = GetStorage();

  Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);

  @override
  void onInit() {
    loadProfile();
    super.onInit();
  }

  void loadProfile() {
    final data = {
      "name": storage.read("name"),
      "email": storage.read("email"),
      "phone": storage.read("phone"),
    };
    profile.value = ProfileModel.fromStorage(data);
  }
}
