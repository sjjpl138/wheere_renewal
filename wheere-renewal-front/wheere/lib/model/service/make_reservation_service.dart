import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class MakeReservationService {
  final MakeReservationRepository _makeReservationRepository = MakeReservationRepository();

  Future<ReservationDTO?> makeReservation(RequestReservationDTO requestReservationDTO) async {
    ReservationDTO? reservationDTO =
    await _makeReservationRepository.makeReservation(requestReservationDTO);
    return reservationDTO;
  }
}