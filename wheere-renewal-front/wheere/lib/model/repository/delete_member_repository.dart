import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class DeleteMemberRepository {
  final DeleteMemberDataSource _deleteMemberDataSource = DeleteMemberDataSource();

  Future deleteMember(int mId) async {
    return await _deleteMemberDataSource.deleteWithRemote(mId);
  }
}