class FirebaseLoginDTO {
  String email;
  String password;

  String vNo;
  int bOutNo;
  String bNo;

  FirebaseLoginDTO({
    required this.email,
    required this.password,
    required this.vNo,
    required this.bOutNo,
    required this.bNo,
  });
}