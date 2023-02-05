import 'remote_data_sources/remote_data_sources.dart';

class BusGetOffRepository {
  final BusGetOffDataSource _busGetOffDataSource = BusGetOffDataSource();

  Future changeRState(String bId) async {
    return await _busGetOffDataSource.writeWithRemote(bId);
  }
}