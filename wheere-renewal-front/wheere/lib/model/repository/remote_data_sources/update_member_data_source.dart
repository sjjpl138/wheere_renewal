import 'package:wheere/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class UpdateMemberDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/members";

  Future writeWithRemote(MemberInfoDTO updateMemberDTO) async {
    try {
      return await BaseRemoteDataSource.put(path, updateMemberDTO.toJson()); //여기 반환값 200 뿐인데..!!
    } catch (e) {
      return null;
    }
  }
}
