class MemberDTO {
  String mId;
  String mName;
  String mSex;
  String mBirthDate;
  String mNum;

  MemberDTO({
    required this.mId,
    required this.mName,
    required this.mSex,
    required this.mBirthDate,
    required this.mNum,
  });

  factory MemberDTO.fromJson(Map<String, dynamic> json) {
    return MemberDTO(
      mId: json["mId"],
      mName: json["mName"],
      mSex: json["mSex"],
      mBirthDate: json["mBirthDate"],
      mNum: json["mNum"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mId": mId,
      "mName": mName,
      "mSex": mSex,
      "mBirthDate": mBirthDate,
      "mNum": mNum,
    };
  }
}
