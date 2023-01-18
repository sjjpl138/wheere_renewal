import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class CheckReservationRepository {
  final CheckReservationDataSource _checkReservationDataSource = CheckReservationDataSource();

  Future<ReservationListDTO?> checkReservation(int mId, String order, int size, String rState) async {
    return await _checkReservationDataSource.readWithRemote(mId, order, size, rState);
  }
}