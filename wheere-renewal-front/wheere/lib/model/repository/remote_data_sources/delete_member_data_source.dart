// import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/remote_data_sources/base_data_source.dart';

class DeleteMemberDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/members/";
  Future deleteWithRemote(int mId) async {
    path = "/api/members/$mId";
    try {
      return await BaseRemoteDataSource.delete(path); //여기 반환값 200
    } catch (e) {
      return null;
    }
  }
}
