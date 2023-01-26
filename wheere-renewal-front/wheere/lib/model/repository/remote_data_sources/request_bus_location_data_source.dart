import 'package:wheere/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class RequestBusLocationDataSource implements BaseRemoteDataSource {
  @override
  String path = "http://apis.data.go.kr/1613000/BusLcInfoInqireService/getRouteAcctoBusLcList";

  Future<BusLocationDTO?> readWithRemote(RequestBusLocationDTO requestDTO, String bId, String vNo) async {
    Map<String, dynamic> queryParams = {
      "serviceKey": requestDTO.serviceKey,
      "pageNo": requestDTO.pageNo,
      "numOfRows": requestDTO.numOfRows,
      "_type": requestDTO.type,
      "cityCode": requestDTO.cityCode,
      "rId": requestDTO.routeId,
    };


    try {
      Map<String, dynamic>? res = await BaseRemoteDataSource.getWithParams(path, queryParams);
      List<Map<String, dynamic>> item = res!['items']['item'];
      var stationName = "stationName";
      for (var bus in item) {
        if(bus['vehicleno'] == vNo){
            stationName = bus['vehicleno'];
        }
      }

      path = "/api/resvs/${bId}";
      Map<String, dynamic>? res_station = await BaseRemoteDataSource.get(path);
      BusLocationDTO busLocation = BusLocationDTO(stationName: stationName, stations: StationListDTO.fromJson(res_station!));
      return busLocation;
    } catch (e) {
      return null;
    }
  }
}