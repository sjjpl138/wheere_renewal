import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';

class SelectTabViewModel extends ChangeNotifier {
  final List<RouteDTO> routes;

  SelectTabViewModel({
    required this.routes,
  });
}