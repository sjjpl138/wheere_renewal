import 'package:wheere/model/dto/dtos.dart';

class Member {
  Member._privateConstructor();

  static final Member _instance = Member._privateConstructor();

  factory Member(MemberDTO? memberDTO) {
    return _instance.._memberDTO = memberDTO;
  }

  MemberDTO? get member => _memberDTO;
  MemberDTO? _memberDTO;
}