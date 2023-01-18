import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class MakeReservationRepository {
  final MakeReservationDataSource _makeReservationDataSource = MakeReservationDataSource();

  Future<ReservationDTO?> makeReservation(RequestReservationDTO requestReservationDTO) async {
    return await _makeReservationDataSource.writeWithRemote(requestReservationDTO);
  }
}