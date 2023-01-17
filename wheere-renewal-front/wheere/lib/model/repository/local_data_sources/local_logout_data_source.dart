import 'package:wheere/model/repository/local_data_sources/base_local_data_source.dart';

class LocalLogoutDataSource implements BaseLocalDataSource {
  Future deleteWithLocal() async {
    await BaseLocalDataSource.delete();
  }
}