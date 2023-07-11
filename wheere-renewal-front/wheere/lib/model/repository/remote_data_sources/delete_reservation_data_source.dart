// import 'package:wheere/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class DeleteReservationDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/resvs/";
  Future deleteWithRemote(String mId, int rId, List<int> bIds) async {
    try {
      return await BaseRemoteDataSource.post("$path$rId", {
        "mId" : mId,
        "bIds" : bIds,
      }); //여기 반환값 200
    } catch (e) {
      return null;
    }
  }
}
