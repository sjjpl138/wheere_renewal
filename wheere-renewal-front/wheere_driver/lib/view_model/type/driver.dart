import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/model/dto/member_dto.dart';
import 'package:wheere_driver/model/service/login_service.dart';
import 'package:wheere_driver/model/service/logout_service.dart';

class Driver extends ChangeNotifier {
  final LoginService _loginService = LoginService();
  final LogoutService _logoutService = LogoutService();

  Driver._privateConstructor();

  static final Driver _instance = Driver._privateConstructor();

  factory Driver() {
    return _instance;
  }

  DriverDTO? get driver => _driverDTO;

  // TODO : 테스트 코드 삭제
  DriverDTO? _driverDTO = DriverDTO(
    dName: "dName",
    bId: 1,
    vNo: "vNo",
    routeId: "routeId",
    bNo: "bNo",
    route: [
      StationDTO(sName: "sName1", sSeq: 5, sId: 1),
      StationDTO(sName: "sName2", sSeq: 6, sId: 2),
      StationDTO(sName: "sName3", sSeq: 7, sId: 3),
      StationDTO(sName: "sName4", sSeq: 8, sId: 4),
      StationDTO(sName: "sName5", sSeq: 9, sId: 5),
      StationDTO(sName: "sName6", sSeq: 10, sId: 6),
      StationDTO(sName: "sName7", sSeq: 11, sId: 7),
    ],
    reservations: [
      ReservationDTO(
        rId: 0,
        startSeq: 10,
        endSeq: 11,
        member: MemberDTO(
          mId: "mId",
          mName: "mName",
          mSex: "mSex",
          mBirthDate: "mBirthDate",
          mNum: "mNum",
        ),
        bId: 1,
      ),
    ],
    fcmToken: '',
    totalSeats: 2,
  );

  Future login(FirebaseLoginDTO firebaseLoginDTO) async {
    await _loginService.loginWithRemote(firebaseLoginDTO);
    notifyListeners();
  }

  Future logout() async {
    await _logoutService
        .logoutWithRemote(driver!.dId)
        .then((value) => _driverDTO = value);
    notifyListeners();
  }
}
