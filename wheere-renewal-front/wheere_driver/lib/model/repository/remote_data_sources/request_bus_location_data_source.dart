import 'package:wheere_driver/model/dto/dtos.dart';
import 'base_remote_data_source.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestBusLocationDataSource implements BaseRemoteDataSource {
  @override
  String path =
      "http://apis.data.go.kr/1613000/BusLcInfoInqireService/getRouteAcctoBusLcList";

  Future<BusLocationDTO?> readWithRemote(
      RequestBusLocationDTO requestDTO, String bId, String vNo) async {
    Map<String, dynamic> queryParams = {
      "serviceKey": requestDTO.serviceKey,
      "pageNo": requestDTO.pageNo.toString(),
      "numOfRows": requestDTO.numOfRows.toString(),
      "_type": requestDTO.type,
      "cityCode": requestDTO.cityCode.toString(),
      "routeId": requestDTO.routeId,
    };

    try {
      Map<String, dynamic>? res = await getWithParams(path, queryParams);
      if(res == null) throw Exception("res is null");
      List<dynamic> item =
      json.decode(json.encode(res['response']['body']['items']['item']));
      var stationName = "stationName";
      for (var bus in item) {
        if (bus['vehicleno'] == vNo) {
          stationName = bus['nodenm'];
          break;
        }
      }

      path = "/api/resvs/${bId}";
      Map<String, dynamic>? res_station = await BaseRemoteDataSource.get(path);
      BusLocationDTO busLocation = BusLocationDTO(
          stationName: stationName,
          stations: StationListDTO.fromJson(res_station!));
      return busLocation;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getWithParams(
      String path, Map<String, dynamic> queryParams) async {
    try {
      var uri = Uri.parse(path).replace(queryParameters: queryParams);
      const headers = {"Accept": "application/json"};
      final res = await http.get(uri, headers: headers);
      switch (res.statusCode) {
        case 200:
          return json.decode(utf8.decode(res.bodyBytes));
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }
}
