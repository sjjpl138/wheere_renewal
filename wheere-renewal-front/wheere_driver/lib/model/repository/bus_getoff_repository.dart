import 'package:wheere_driver/model/dto/bus_getoff_dto.dart';
import 'remote_data_sources/remote_data_sources.dart';

class BusGetOffRepository {
  final BusGetOffDataSource _busGetOffDataSource = BusGetOffDataSource();

  Future changeRState(BusGetOffDTO getOffDTO) async {
    return await _busGetOffDataSource.writeWithRemote(getOffDTO);
  }
}