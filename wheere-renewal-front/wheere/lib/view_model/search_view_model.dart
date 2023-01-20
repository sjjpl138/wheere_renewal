import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/services.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/util/utils.dart';
import 'package:wheere/view/select/select_page.dart';

import 'type/types.dart';

class SearchViewModel extends ChangeNotifier {
  final RequestRouteService _requestRouteService = RequestRouteService();

  PlaceInfo? sPlaceInfo;
  PlaceInfo? ePlaceInfo;
  String rDate = dateFormat.format(DateTime.now());

  Future searchStartPlaces(BuildContext context) async {
    await _searchPlaces(context).then((value) {
      if (value == null) return;
      double x = value.result.geometry!.location.lng; // 경도
      double y = value.result.geometry!.location.lat; // 위도
      final placeName = value.result.name;
      sPlaceInfo = PlaceInfo(placeName: placeName, x: x, y: y);
    });
    notifyListeners();
  }

  Future searchEndPlaces(BuildContext context) async {
    await _searchPlaces(context).then((value) {
      if (value == null) return;
      double x = value.result.geometry!.location.lng; // 경도
      double y = value.result.geometry!.location.lat; // 위도
      final placeName = value.result.name;
      ePlaceInfo = PlaceInfo(placeName: placeName, x: x, y: y);
    });
    notifyListeners();
  }

  Future searchRoutes(BuildContext context) async {
    // TODO : 테스트 코드 삭제 필요

    List<RouteDTO> routes = [
      RouteDTO(
        sWalkingTime: 'sWalkingTime',
        price: 1400,
        payment: 1,
        buses: [
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            eWalkingTime: 'eWalkingTime',
            leftSeats: 2,
          ),
        ],
      ),
      RouteDTO(
        sWalkingTime: 'sWalkingTime',
        price: 1400,
        payment: 1,
        buses: [
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            eWalkingTime: 'eWalkingTime',
            leftSeats: 2,
          ),
          BusDTO(
            bId: 1,
            bNo: 'bNo',
            sStationId: 1,
            sStationName: 'sStationName',
            sTime: "sTime",
            eStationId: 1,
            eStationName: 'eStationName',
            eTime: "eTime",
            eWalkingTime: 'eWalkingTime',
            leftSeats: 2,
          ),
        ],
      ),
    ];

    RouteFullListDTO routeFullListDTO = RouteFullListDTO(routeFullList: [
      RoutesByHoursDTO(selectTime: "15시", routes: routes),
      RoutesByHoursDTO(selectTime: "16시", routes: routes),
      RoutesByHoursDTO(selectTime: "17시", routes: routes),
      RoutesByHoursDTO(selectTime: "18시", routes: routes),
      RoutesByHoursDTO(selectTime: "19시", routes: routes),
      RoutesByHoursDTO(selectTime: "20시", routes: routes),
      RoutesByHoursDTO(selectTime: "21시", routes: routes),
      RoutesByHoursDTO(selectTime: "22시", routes: routes),
      RoutesByHoursDTO(selectTime: "23시", routes: routes),
    ], outTrafficCheck: 1);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectPage(
          routeFullListDTO: routeFullListDTO,
          rDate: rDate,
        ),
      ),
    );

    if (sPlaceInfo == null || ePlaceInfo == null) return;
    await _requestRouteService
        .requestRoute(RequestRouteDTO(
      sx: sPlaceInfo!.x,
      sy: sPlaceInfo!.y,
      ex: ePlaceInfo!.x,
      ey: ePlaceInfo!.y,
      rDate: rDate,
    ))
        .then((value) {
      if (value != null) {
        if (value.outTrafficCheck == 1) {
          // TODO : 계속하기 팝업 띄우기
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectPage(
              routeFullListDTO: value,
              rDate: rDate,
            ),
          ),
        );
      }
    });
  }

  Future<PlacesDetailsResponse?> _searchPlaces(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: dotenv.get('GOOGLE_MAP_KEY'),
      onError: (PlacesAutocompleteResponse response) {
        print("error: ${response.errorMessage}");
      },
      mode: Mode.overlay,
      language: 'ko',
      strictbounds: false,
      types: [],
      decoration: const InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusSize)),
          borderSide: BorderSide(
            width: kLineSize,
            color: CustomColor.backGroundSubColor,
          ),
        ),
      ),
      components: [Component(Component.country, "kr")],
      region: "kr",
      logo: Column(),
      offset: 0,
    );
    if (p != null) {
      GoogleMapsPlaces places = GoogleMapsPlaces(
          apiKey: dotenv.get('GOOGLE_MAP_KEY'),
          apiHeaders: await const GoogleApiHeaders().getHeaders());
      return await places.getDetailsByPlaceId(p.placeId!, language: "ko");
    }
    return null;
  }
}
