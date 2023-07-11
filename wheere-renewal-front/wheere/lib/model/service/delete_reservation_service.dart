import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class DeleteReservationService {
  final DeleteReservationRepository _deleteReservationRepository = DeleteReservationRepository();

  Future deleteReservation(String mId, int rId, List<int> bIds) async {
    return await _deleteReservationRepository.deleteReservation(mId, rId, bIds);
  }
}