import 'package:wheere_driver/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class RequestBusLocationDataSource implements BaseRemoteDataSource {
  @override
  String path = "http://apis.data.go.kr/1613000/BusLcInfoInqireService/getRouteAcctoBusLcList";

  Future<BusLocationDTO?> readWithRemote(RequestBusLocationDTO requestDTO) async {
    Map<String, dynamic> queryParams = {
      "serviceKey": requestDTO.serviceKey,
      "pageNo": requestDTO.pageNo,
      "numOfRows": requestDTO.numOfRows,
      "_type": requestDTO.type,
      "cityCode": requestDTO.cityCode,
      "rId": requestDTO.rId,
    };
    try {
      Map<String, dynamic>? res = await BaseRemoteDataSource.getWithParams(path, queryParams);
      return res != null ? BusLocationDTO.fromJson(res) : null;
    } catch (e) {
      return null;
    }
  }
}