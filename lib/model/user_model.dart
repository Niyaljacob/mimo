class RegisterModel {
  String fullName;
  String email;
  String password;

  RegisterModel({
    required this.fullName,
    required this.email,
    required this.password,
  });

  // Convert a RegisterModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }

  // Create a RegisterModel object from a JSON map
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
    );
  }

}