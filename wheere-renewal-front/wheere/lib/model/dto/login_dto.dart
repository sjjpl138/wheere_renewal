class LoginDTO {
  String mId;

  LoginDTO({
    required this.mId,
  });

  Map<String, dynamic> toJson() {
    return {
      "mId": mId,
    };
  }
}