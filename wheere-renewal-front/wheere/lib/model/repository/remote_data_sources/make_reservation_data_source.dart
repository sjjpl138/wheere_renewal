import 'package:http/http.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/remote_data_sources/base_data_source.dart';

class MakeReservationDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/resvs";

  // //requestReservationDTO를 여기서 생성하면
  // Future<ReservationDTO?> writeWithRemote(mId, bId, sStationId, eStationId, rDate) async {
  //   try {
  //
  //     RequestReservationDTO? requestReservationDTO = RequestReservationDTO(
  //         mId: mId,
  //         bId: bId,
  //         sStationId: sStationId,
  //         eStationId: eStationId,
  //         rDate: rDate);
  //     Map<String, dynamic>? res = requestReservationDTO != null
  //         ? await BaseRemoteDataSource.post(path, requestReservationDTO.toJson())
  //         : null;
  //     return res != null ? ReservationDTO.fromJson(res) : null;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  //requestReservationDTO를 여기서 생성하지 않고 인자로 받아온다면
  Future<ReservationDTO?> writeWithRemote(RequestReservationDTO requestReservationDTO) async {
    try {
      Map<String, dynamic>? res = requestReservationDTO != null
          ? await BaseRemoteDataSource.post(path, requestReservationDTO.toJson())
          : null;
      return res != null ? ReservationDTO.fromJson(res) : null;
    } catch (e) {
      return null;
    }
  }
}
