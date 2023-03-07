class MemberInfoDTO {
  String mId;
  String mName;
  String mSex;
  String mBirthDate;
  String mNum;

  MemberInfoDTO({
    required this.mId,
    required this.mName,
    required this.mSex,
    required this.mBirthDate,
    required this.mNum,
  });

  Map<String, dynamic> toJson() {
    return {
      "mId": mId,
      "mName": mName,
      "mSex": mSex,
      "mBirthDate": mBirthDate,
      "mNum": mNum
    };
  }
}
