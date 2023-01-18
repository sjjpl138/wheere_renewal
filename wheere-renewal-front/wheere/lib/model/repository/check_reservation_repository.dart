import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class CheckReservationRepository {
  final CheckReservationDataSource _checkReservationDataSource = CheckReservationDataSource();

  Future<ReservationListDTO?> checkReservation(int mId) async {
    return await _checkReservationDataSource.readWithRemote(mId);
  }
}