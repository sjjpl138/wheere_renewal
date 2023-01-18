import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class CheckReservationService {
  final CheckReservationRepository _checkReservationRepository = CheckReservationRepository();

  Future<ReservationListDTO?> checkReservation(int mId) async {
    ReservationListDTO? reservationListDTO =
    await _checkReservationRepository.checkReservation(mId);
    return reservationListDTO;
  }
}