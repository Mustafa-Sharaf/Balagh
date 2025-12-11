class UserModel {
  String userName;
  String email;
  String password;
  String phoneNumber;
  String role;

  UserModel({
    required this.userName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.role = "User", // default
  });

  Map<String, dynamic> toJson() {
    return {
      "UserName": userName,
      "Email": email,
      "Password": password,
      "PhoneNumber": phoneNumber,
      "Role": role,
    };
  }
}
