import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class DeleteReservationRepository {
  final DeleteReservationDataSource _deleteReservationDataSource = DeleteReservationDataSource();

  Future deleteReservation(String mId, int rId, List<int> bIds) async {
    return await _deleteReservationDataSource.deleteWithRemote(mId, rId, bIds);
  }
}