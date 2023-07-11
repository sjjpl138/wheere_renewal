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

  @override
  int get hashCode => mId.hashCode;

  @override
  bool operator ==(covariant MemberDTO other) => mId.compareTo(other.mId) == 0;

  factory MemberDTO.fromJson(Map<String, dynamic> json) {
    print(json);
    return MemberDTO(
      mId: json["mId"].toString(),
      mName: json["mName"].toString(),
      mSex: json["mSex"].toString(),
      mBirthDate: json["mBirthDate"].toString(),
      mNum: json["mNum"].toString(),
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
