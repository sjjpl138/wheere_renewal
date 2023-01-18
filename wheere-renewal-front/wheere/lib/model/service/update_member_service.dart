import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class UpdateMemberService {
  final UpdateMemberRepository _updateMemberRepository = UpdateMemberRepository();

  Future updateMember(MemberDTO updateMemberDTO) async {
    return await _updateMemberRepository.updateMember(updateMemberDTO);
  }
}