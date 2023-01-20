class FirebaseSignUpDTO {
  String email;
  String password;
  String mName;
  String mSex;
  String mBirthDate;
  String mNum;

  FirebaseSignUpDTO({
    required this.email,
    required this.password,
    required this.mName,
    required this.mSex,
    required this.mBirthDate,
    required this.mNum,
  });
}