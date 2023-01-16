class MemberDTO {
  String mId;
  String mName;
  String mSex;
  String mBrithDate;
  String mNum;
  String fcmToken;

  MemberDTO({
    required this.mId,
    required this.mName,
    required this.mSex,
    required this.mBrithDate,
    required this.mNum,
    required this.fcmToken,
  });

  factory MemberDTO.fromJson(Map<String, dynamic> json) {
    return MemberDTO(
      mId: json["mId"],
      mName: json["mName"],
      mSex: json["mSex"],
      mBrithDate: json["mBirthDate"],
      mNum: json["mNum"],
      fcmToken: json['fcmToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mId": mId,
      "mName": mName,
      "mSex": mSex,
      "mBirthDate": mBrithDate,
      "mNum": mNum,
      "fcmToken": fcmToken,
    };
  }
}