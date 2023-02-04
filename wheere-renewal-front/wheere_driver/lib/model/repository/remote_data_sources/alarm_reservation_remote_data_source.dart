import 'package:wheere_driver/model/dto/dtos.dart';
import 'base_remote_data_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class AlarmReservationDataSource implements BaseRemoteDataSource {
  @override
    String path = "";
  Future<ReservationDTO?> writeWithRemote(RemoteMessage message) async {
    try {
      return ReservationDTO.fromJson(message.data);
    } catch (e) {
      return null;
    }
  }
}
