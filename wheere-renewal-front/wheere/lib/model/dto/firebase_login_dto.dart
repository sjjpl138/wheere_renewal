class FirebaseLoginDTO {
  String email;
  String password;

  FirebaseLoginDTO({
    required this.email,
    required this.password,
  });

  factory FirebaseLoginDTO.fromJson(Map<String, dynamic> json) {
    return FirebaseLoginDTO(
      email: json["email"],
      password: json["password"],
    );
  }
}