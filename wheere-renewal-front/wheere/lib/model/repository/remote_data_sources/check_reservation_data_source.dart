import 'package:http/http.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/remote_data_sources/base_data_source.dart';

class CheckReservationDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/resvs";

  Future<ReservationListDTO?> readWithRemote(int mId) async {
    path = "/api/resvs/$mId";
    try {
      Map<String, dynamic>? res = await BaseRemoteDataSource.get(path); //쿼리 어떻게 보내지.. 노션 적힌 내용 이해 x
      return res != null ? ReservationListDTO.fromJson(res) : null;
    } catch (e) {
      return null;
    }
  }
}
