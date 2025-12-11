class ProfileModel {
  final String name;
  final String email;
  final String phone;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  factory ProfileModel.fromStorage(Map data) {
    return ProfileModel(
      name: data["name"] ?? "",
      email: data["email"] ?? "",
      phone: data["phone"] ?? "",
    );
  }
}
