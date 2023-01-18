import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/remote_data_sources/base_data_source.dart';

class RatingDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/members/rate";

  Future writeWithRemote(RatingDTO ratingDTO) async {
    try {
      return await BaseRemoteDataSource.post(path, ratingDTO.toJson());
    } catch (e) {
      return null;
    }
  }
}
