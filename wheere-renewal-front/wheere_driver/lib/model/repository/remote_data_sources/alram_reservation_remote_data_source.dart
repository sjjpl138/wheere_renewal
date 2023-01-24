import 'package:wheere_driver/model/dto/dtos.dart';
import 'base_remote_data_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class AlramReservationDataSource implements BaseRemoteDataSource {
  @override
    String path = "";
  Future<AlarmReservationDTO?> writeWithRemote(RemoteMessage message) async {
    try {
      return AlarmReservationDTO.fromJson(message.data);
    } catch (e) {
      return null;
    }
  }
}
