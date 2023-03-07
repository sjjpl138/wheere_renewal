import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class CheckReservationService {
  final CheckReservationRepository _checkReservationRepository = CheckReservationRepository();

  Future<ReservationCheckDTO?> checkReservation(RequestReservationCheckDTO requestDTO) async {
    ReservationCheckDTO? reservationCheckDTO =
    await _checkReservationRepository.checkReservation(requestDTO);
    return reservationCheckDTO;
  }
}