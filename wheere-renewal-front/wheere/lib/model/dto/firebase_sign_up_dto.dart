class FirebaseSignUpDTO {
  String email;
  String password;

  FirebaseSignUpDTO({
    required this.email,
    required this.password,
  });

  factory FirebaseSignUpDTO.fromJson(Map<String, dynamic> json) {
    return FirebaseSignUpDTO(
      email: json["email"],
      password: json["password"],
    );
  }
}