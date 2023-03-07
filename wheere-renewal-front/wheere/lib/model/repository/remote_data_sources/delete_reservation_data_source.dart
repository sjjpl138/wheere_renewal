// import 'package:wheere/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class DeleteReservationDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/resvs/";
  Future deleteWithRemote(int rId) async {
    path = "/api/members/$rId";
    try {
      return await BaseRemoteDataSource.delete(path); //여기 반환값 200
    } catch (e) {
      return null;
    }
  }
}
