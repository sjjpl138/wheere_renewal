import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class RatingRepository {
  final RatingDataSource _ratingDataSource = RatingDataSource();

  Future rating(RatingDTO ratingDTO) async {
    return await _ratingDataSource.writeWithRemote(ratingDTO);
  }
}