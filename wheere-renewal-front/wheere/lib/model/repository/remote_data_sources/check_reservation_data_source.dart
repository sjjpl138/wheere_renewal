import 'package:wheere/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class CheckReservationDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/resvs";

  Future<ReservationListDTO?> readWithRemote(RequestReservationCheckDTO requestDTO) async {

    path = "/api/resvs/${requestDTO.mId}";
    //쿼리 ?order=latest|oldest&rState=RESERVED&size=10
    //rState= RESERVED | PAID | CANCEL | RVW_WAIT | RVW_COMP
    //모두일 경우 rState생략  ?order=oldest&size=10

     Map<String, dynamic> queryParams = {
      "order": requestDTO.order,
      "size": requestDTO.size,
    };
     if (requestDTO.rState != "all"){
       queryParams["rState"] = requestDTO.rState;
     }
    try {
      Map<String, dynamic>? res = await BaseRemoteDataSource.getWithParams(path, queryParams);
      return res != null ? ReservationListDTO.fromJson(res) : null;
    } catch (e) {
      return null;
    }
  }
}
