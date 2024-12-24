class RegisterModel {
  String fullName;
  String email;
  String password;
  String? location;  // Make location nullable (optional)
  String? aboutMe;   // Make aboutMe nullable (optional)

  RegisterModel({
    required this.fullName,
    required this.email,
    required this.password,
    this.location,   // Make location optional in the constructor
    this.aboutMe,    // Make aboutMe optional in the constructor
  });

  // Convert a RegisterModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'location': location,   // Include location in toJson (can be null)
      'aboutMe': aboutMe,     // Include aboutMe in toJson (can be null)
    };
  }

  // Create a RegisterModel object from a JSON map
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      location: json['location'] ?? '',   // Handle null if location is not provided
      aboutMe: json['aboutMe'] ?? '',     // Handle null if aboutMe is not provided
    );
  }
}
