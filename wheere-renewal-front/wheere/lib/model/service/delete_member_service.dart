import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class DeleteMemberService {
  final DeleteMemberRepository _deleteMemberRepository = DeleteMemberRepository();

  Future deleteMember(int mId) async {
    return await _deleteMemberRepository.deleteMember(mId);
  }
}