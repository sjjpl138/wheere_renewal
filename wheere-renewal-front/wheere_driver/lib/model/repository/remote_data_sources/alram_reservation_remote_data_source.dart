import 'package:wheere_driver/model/dto/dtos.dart';
import 'base_remote_data_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class AlramReservationDataSource implements BaseRemoteDataSource {
  @override
    String path = "";
  Future<AlramReservationDTO?> writeWithRemote(RemoteMessage message) async {
    try {
      return AlramReservationDTO.fromJson(message.data);
    } catch (e) {
      return null;
    }
  }
}
