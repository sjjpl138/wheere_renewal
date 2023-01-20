import 'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class RatingService {
  final RatingRepository _ratingRepository = RatingRepository();

  Future rating(RatingDTO ratingDTO) async {
    return await _ratingRepository.rating(ratingDTO);
  }
}