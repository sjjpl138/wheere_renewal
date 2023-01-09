class MemberDTO {
  String mId;
  String mName;
  String mSex;
  String mBrithDate;
  String mNum;

  MemberDTO({
    required this.mId,
    required this.mName,
    required this.mSex,
    required this.mBrithDate,
    required this.mNum,
  });

  factory MemberDTO.fromJson(String mId, Map<String, dynamic> json) {
    return MemberDTO(
      mId: mId,
      mName: json["mName"],
      mSex: json["mSex"],
      mBrithDate: json["mBrithDate"],
      mNum: json["mNum"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mId": mId,
      "mName": mName,
      "mSex": mSex,
      "mBirthDate": mBrithDate,
      "mNum": mNum,
    };
  }
}