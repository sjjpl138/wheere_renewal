class AlarmMemberDTO {
  String mId;
  String mName;
  String mSex;
  String mBirthDate;
  String mNum;

  AlarmMemberDTO({
    required this.mId,
    required this.mName,
    required this.mSex,
    required this.mBirthDate,
    required this.mNum,
  });

  factory AlarmMemberDTO.fromJson(Map<String, dynamic> json) {
    return AlarmMemberDTO(
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
