import 'package:intl/intl.dart';
import 'package:wheere/model/dto/dtos.dart';
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

  factory RouteFullList.fromJson(Map<String, dynamic> json) {
    var list = json['selects'] as List;
    List<RoutesByHours> getList =
        list.map((i) => RoutesByHours.fromJson(i)).toList();
    return RouteFullList(
      outTrafficCheck: json['outTrafficCheck'],
      routeByHoursList: getList,
    );
  }

  factory RouteFullList.fromRouteFullListDTO(
      RouteFullListDTO routeFullListDTO) {
    final NumberFormat numberFormat = NumberFormat("00");
    List<RoutesByHours> routeByHoursList = [];
    for (int i = 1; i < 24; i++) {
      routeByHoursList
          .add(RoutesByHours(selectTime: numberFormat.format(i), routes: []));
    }
    for (int k = 0; k < routeFullListDTO.routes.length; k++) {
      var routeDTO = routeFullListDTO.routes[k];
      Map<IndexType, List<BusData>> fullBuses = {};
      for (int i = 1; i < routeDTO.subRoutes.length; i += 2) {
        BusRouteDTO busRouteDTO = routeDTO.subRoutes[i].busRoute!;
        for (int j = 0; j < busRouteDTO.bIdList.length; j++) {
          if (fullBuses[IndexType(routeIndex: k, busRouteIndex: j)] != null) {
            fullBuses[IndexType(routeIndex: k, busRouteIndex: j)]!.add(BusData(
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
            fullBuses[IndexType(routeIndex: k, busRouteIndex: j)] = [
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

      for (IndexType indexType in fullBuses.keys) {
        RouteDTO routeDTO = routeFullListDTO.routes[indexType.routeIndex];
        routeByHoursList[numberFormat
                .parse(fullBuses[indexType]![0].sTime.substring(0, 1))
                .toInt()]
            .routes
            .add(RouteData(
                payment: routeDTO.payment,
                buses: fullBuses[indexType]!,
                sWalkingTime: routeDTO.subRoutes[0].sectionTime.toString()));
      }
    }
    return RouteFullList(
      outTrafficCheck: routeFullListDTO.outTrafficCheck,
      routeByHoursList: routeByHoursList,
    );
  }
}

class IndexType {
  int routeIndex;
  int busRouteIndex;

  IndexType({
    required this.routeIndex,
    required this.busRouteIndex,
  });

  @override
  int get hashCode => routeIndex.hashCode;

  @override
  bool operator ==(covariant IndexType other) => routeIndex == other.routeIndex;
}
