import 'dart:convert';
import 'package:wheere/model/dto/dtos.dart';
import 'base_remote_data_source.dart';
import 'package:http/http.dart' as http;

class RequestBusLocationDataSource implements BaseRemoteDataSource {
  @override
  String path =
      "http://apis.data.go.kr/1613000/BusLcInfoInqireService/getRouteAcctoBusLcList";

  Future<BusLocationDTO?> readWithRemote(
      RequestBusLocationDTO requestDTO, int bId, String vNo) async {
    Map<String, dynamic> queryParams = {
      "serviceKey": requestDTO.serviceKey,
      "pageNo": requestDTO.pageNo.toString(),
      "numOfRows": requestDTO.numOfRows.toString(),
      "_type": requestDTO.type,
      "cityCode": requestDTO.cityCode.toString(),
      "routeId": requestDTO.routeId,
    };

    try {
      path =
          "http://apis.data.go.kr/1613000/BusLcInfoInqireService/getRouteAcctoBusLcList";
      Map<String, dynamic>? res = await getWithParams(path, queryParams);
      if (res == null) throw Exception("res is null");
      List<dynamic> item =
          json.decode(json.encode(res['response']['body']['items']['item']));
      // type 'String' is not a subtype of type 'int' of 'index'
      var stationName = "stationName";
      for (var bus in item) {
        if (bus['vehicleno'] == vNo) {
          stationName = bus['nodenm'];
          break;
        }
      }

      print(stationName);
      path = "/api/stations/${bId}";
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
      print('start getWithParams');
      var uri = Uri.parse(path).replace(queryParameters: queryParams);
      const headers = {"Content-Type": "application/json"};
      print('before get : $uri');
      final res = await http.get(uri, headers: headers);
      print(json.decode(utf8.decode(res.bodyBytes)));
      switch (res.statusCode) {
        case 200:
          return json.decode(utf8.decode(res.bodyBytes));
        default:
          return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
