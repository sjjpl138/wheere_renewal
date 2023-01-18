import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/remote_data_sources/base_data_source.dart';

class MakeReservationDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/resvs";
  Future<ReservationDTO?> writeWithRemote(RequestReservationDTO requestReservationDTO) async {
    try {
      Map<String, dynamic>? res = await BaseRemoteDataSource.post(path, requestReservationDTO.toJson());
      return res != null ? ReservationDTO.fromJson(res) : null;
    } catch (e) {
      return null;
    }
  }
}
