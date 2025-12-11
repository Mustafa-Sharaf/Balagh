class UserLoginModel {
  final String email;
  final String password;
  final String deviceToken;

  UserLoginModel({
    required this.email,
    required this.password,
    required this.deviceToken,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "deviceToken": deviceToken,
  };
}
