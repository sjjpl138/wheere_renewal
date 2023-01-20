import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class DeleteReservationService {
  final DeleteReservationRepository _deleteReservationRepository = DeleteReservationRepository();

  Future deleteReservation(int rId) async {
    return await _deleteReservationRepository.deleteReservation(rId);
  }
}