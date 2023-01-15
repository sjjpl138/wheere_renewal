import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/rating_view_model.dart';

class RatingView extends StatefulWidget {
  final RatingViewModel ratingViewModel;

  const RatingView({Key? key, required this.ratingViewModel}) : super(key: key);

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  late final _ratingViewModel = widget.ratingViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        title: "평점 작성하기",
        leading: BackIconButton(
          onPressed: _ratingViewModel.navigatePop,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: CustomColor.backgroundMainColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kPaddingLargeSize),
                const Text(
                  "탑승 정보",
                  style: kTextMainStyleLarge,
                ),
                const SizedBox(height: kPaddingLargeSize),
                ReservationInfo(
                  bNo: _ratingViewModel.reservation.bNo,
                  rTime: _ratingViewModel.reservation.rTime,
                  sStationName: _ratingViewModel.reservation.sStationName,
                  sStationTime: _ratingViewModel.reservation.sTime,
                  eStationName: _ratingViewModel.reservation.eStationName,
                  eStationTime: _ratingViewModel.reservation.eTime,
                ),
                const Text(
                  "평점",
                  style: kTextMainStyleLarge,
                ),
                const SizedBox(height: kPaddingLargeSize),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColor.backGroundSubColor,
                      borderRadius: BorderRadius.circular(kBorderRadiusSize),
                    ),
                    child: Center(
                      child: RatingBar.builder(
                        initialRating: _ratingViewModel.rating,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(
                          horizontal: kPaddingLargeSize,
                          vertical: kPaddingMiddleSize,
                        ),
                        unratedColor: CustomColor.itemDisabledColor,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: CustomColor.itemSubColor,
                        ),
                        onRatingUpdate: _ratingViewModel.updateRating,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: kPaddingLargeSize),
                CustomOutlinedButton(
                  onPressed: _ratingViewModel.sendRating,
                  text: "평점 작성",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
