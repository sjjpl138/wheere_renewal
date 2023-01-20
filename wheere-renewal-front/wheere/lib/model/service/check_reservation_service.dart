import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class CheckReservationService {
  final CheckReservationRepository _checkReservationRepository = CheckReservationRepository();

  Future<ReservationListDTO?> checkReservation(int mId, String order, int size, String rState) async {
    ReservationListDTO? reservationListDTO =
    await _checkReservationRepository.checkReservation(mId, order, size, rState);
    return reservationListDTO;
  }
}