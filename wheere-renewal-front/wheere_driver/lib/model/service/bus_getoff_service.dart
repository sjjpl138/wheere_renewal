import 'package:wheere_driver/model/repository/bus_getoff_repository.dart';

class BusGetOffService {
  final BusGetOffRepository _busGetOffRepository = BusGetOffRepository();

  Future sendReservationStateChange(int bId) async {
    return _busGetOffRepository.changeRState(bId);
  }
}