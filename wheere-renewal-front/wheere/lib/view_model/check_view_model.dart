import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/bus_current_info/bus_current_info_page.dart';
import 'type/types.dart';

class CheckViewModel extends ChangeNotifier {
  bool isMoreRequesting = false;
  double _dragDistance = 0.0;
  String order = "latest";
  String rState = "RESERVED";
  List<String> orderList = ["latest", "oldest"];
  List<String> rStateList = [
    "RESERVED",
    "PAID",
    "CANCEL",
    "RVW_WAIT",
    "RVW_COMP"
  ];

  final ScrollController scrollController = ScrollController();

  CheckViewModel() {
    print("checkViewModel is created");
    ReservationList().checkReservation("", "");
  }

  void onOrderChanged(dynamic value) {
    order = value;
    notifyListeners();
  }

  void onRStateChanged(dynamic value) {
    rState = value;
    notifyListeners();
  }

  void navigateToBusCurrentInfoPage(
      BuildContext context, ReservationDTO reservation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusCurrentInfoPage(reservation: reservation),
      ),
    );
  }

  void checkReservation() async {
    await ReservationList().checkReservation(
      order,
      rState,
      isNew: true,
    );
    scrollController.jumpTo(
      scrollController.position.minScrollExtent,
    );
    notifyListeners();
  }

  //스크롤 이벤트 처리
  void scrollNotification(notification) {
    // 스크롤 최대 범위
    var containerExtent = notification.metrics.viewportDimension;

    if (notification is ScrollStartNotification) {
      // 스크롤을 시작하면 발생(손가락으로 리스트를 누르고 움직이려고 할때)
      // 스크롤 거리값을 0으로 초기화함
      _dragDistance = 0;
    } else if (notification is OverscrollNotification) {
      // 안드로이드에서 동작
      // 스크롤을 시작후 움직일때 발생(손가락으로 리스트를 누르고 움직이고 있을때 계속 발생)
      // 스크롤 움직인 만큼 빼준다.(notification.overscroll)
      _dragDistance -= notification.overscroll;
    } else if (notification is ScrollUpdateNotification) {
      // ios에서 동작
      // 스크롤을 시작후 움직일때 발생(손가락으로 리스트를 누르고 움직이고 있을때 계속 발생)
      // 스크롤 움직인 만큼 빼준다.(notification.scrollDelta)
      _dragDistance -= notification.scrollDelta ?? 0.0;
    } else if (notification is ScrollEndNotification) {
      // 스크롤이 끝났을때 발생(손가락을 리스트에서 움직이다가 뗐을때 발생)

      // 지금까지 움직인 거리를 최대 거리로 나눈다.
      var percent = _dragDistance / (containerExtent);
      // 해당 값이 -0.4(40프로 이상) 아래서 위로 움직였다면
      if (percent <= -0.4) {
        // maxScrollExtent는 리스트 가장 아래 위치 값
        // pixels는 현재 위치 값
        // 두 같이 같다면(스크롤이 가장 아래에 있다)
        if (notification.metrics.maxScrollExtent ==
            notification.metrics.pixels) {
          // 서버에서 데이터를 더 가져오는 효과를 주기 위함
          // 하단에 프로그레스 서클 표시용
          isMoreRequesting = true;
          notifyListeners();
          // 서버에서 데이터 가져온다.
          ReservationList().checkReservation(order, rState).then((value) {
            // 다 가져오면 하단 표시 서클 제거
            isMoreRequesting = false;
            notifyListeners();
          });
        }
      }
    }
  }
}
