import 'package:wheere/model/dto/route_dto.dart';

class SelectDTO {
  String selectTIme;
  List<RouteDTO> routes;

  SelectDTO({
    required this.selectTIme,
    required this.routes,
  });
}