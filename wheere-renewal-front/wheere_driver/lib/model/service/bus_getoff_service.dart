import 'package:wheere_driver/model/dto/bus_getoff_dto.dart';
import 'package:wheere_driver/model/repository/bus_getoff_repository.dart';

class BusGetOffService {
  final BusGetOffRepository _busGetOffRepository = BusGetOffRepository();

  Future sendReservationStateChange(BusGetOffDTO getOffDTO) async {
    return _busGetOffRepository.changeRState(getOffDTO);
  }
}