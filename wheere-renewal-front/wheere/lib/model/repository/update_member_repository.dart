import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class UpdateMemberRepository {
  final UpdateMemberDataSource _updateMemberDataSource = UpdateMemberDataSource();

  Future updateMember(MemberInfoDTO updateMemberDTO) async {
    return await _updateMemberDataSource.writeWithRemote(updateMemberDTO);
  }
}