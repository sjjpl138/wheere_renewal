import 'package:intl/intl.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/util/date_formats.dart';
import 'package:wheere/view_model/type/bus_data.dart';
import 'package:wheere/view_model/type/route_data.dart';
import 'routes_by_hours.dart';

class RouteFullList {
  int outTrafficCheck;
  List<RoutesByHours> routeByHoursList;

  RouteFullList({
    required this.outTrafficCheck,
    required this.routeByHoursList,
  });

  static final NumberFormat _numberFormat = NumberFormat("00");

  factory RouteFullList.fromRouteFullListDTO(
      RouteFullListDTO routeFullListDTO) {
    List<RoutesByHours> routeByHoursList = [];
    for (int i = 0; i < 24; i++) {
      routeByHoursList
          .add(RoutesByHours(selectTime: _numberFormat.format(i), routes: []));
    }
    Map<int, List<List<BusData>>> fullBuses = {};
    for (int k = 0; k < routeFullListDTO.routes.length; k++) {
      var routeDTO = routeFullListDTO.routes[k];
      for (int i = 1; i < routeDTO.subRoutes.length; i += 2) {
        BusRouteDTO busRouteDTO = routeDTO.subRoutes[i].busRoute!;
        for (int j = 0; j < busRouteDTO.bIdList.length; j++) {
          if (fullBuses[k] != null) {
            fullBuses[k]![i ~/ 2].add(BusData(
              bId: busRouteDTO.bIdList[j],
              bNo: busRouteDTO.bNo,
              sStationId: busRouteDTO.sStationId,
              sStationName: busRouteDTO.sStationName,
              sTime: busRouteDTO.sTimeList[j],
              eStationId: busRouteDTO.eStationId,
              eStationName: busRouteDTO.eStationName,
              eTime: busRouteDTO.eTimeList[j],
              eWalkingTime: routeDTO.subRoutes[i + 1].sectionTime.toString(),
              leftSeats: busRouteDTO.leftSeatsList[j],
            ));
          } else {
            fullBuses[k] = [];
            for (var i = 0; i < routeDTO.subRoutes.length ~/ 2; i++) {
              fullBuses[k]!.add([]);
            }
            fullBuses[k]![i ~/ 2] = [
              BusData(
                bId: busRouteDTO.bIdList[j],
                bNo: busRouteDTO.bNo,
                sStationId: busRouteDTO.sStationId,
                sStationName: busRouteDTO.sStationName,
                sTime: busRouteDTO.sTimeList[j],
                eStationId: busRouteDTO.eStationId,
                eStationName: busRouteDTO.eStationName,
                eTime: busRouteDTO.eTimeList[j],
                eWalkingTime: routeDTO.subRoutes[i + 1].sectionTime.toString(),
                leftSeats: busRouteDTO.leftSeatsList[j],
              )
            ];
          }
        }
      }
    }
    for (int i in fullBuses.keys) {
      RouteDTO routeDTO = routeFullListDTO.routes[i];
      _dfs(routeDTO, fullBuses[i]!, routeByHoursList, [], 0,
          routeDTO.subRoutes.length ~/ 2);
    }
    return RouteFullList(
      outTrafficCheck: routeFullListDTO.outTrafficCheck,
      routeByHoursList: routeByHoursList,
    );
  }

  static void _dfs(
      RouteDTO routeDTO,
      List<List<BusData>> fullBuses,
      List<RoutesByHours> routeByHoursList,
      List<BusData> temp,
      int depth,
      int n) {
    if (depth == n) {
      routeByHoursList[
              _numberFormat.parse(temp[0].sTime.substring(0, 2)).toInt()]
          .routes
          .add(RouteData(
              payment: routeDTO.payment,
              buses: temp,
              sWalkingTime: routeDTO.subRoutes[0].sectionTime.toString()));
      return;
    }
    List<BusData> nextTemp;
    for (var i = 0; i < fullBuses[depth].length; i++) {
      nextTemp = [...temp];
      if (depth != 0 &&
          vanillaTimeFormat.parse(nextTemp[depth - 1].eTime).compareTo(
                  vanillaTimeFormat.parse(fullBuses[depth][i].sTime).add(
                      Duration(
                          minutes:
                              int.parse(fullBuses[depth][i].eWalkingTime)))) >
              0) return;
      nextTemp.add(fullBuses[depth][i]);
      _dfs(routeDTO, fullBuses, routeByHoursList, nextTemp, depth + 1, n);
    }
  }
}
