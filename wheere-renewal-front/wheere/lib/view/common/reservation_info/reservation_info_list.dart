import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/custom_outlined_button.dart';
import 'package:wheere/view/common/reservation_info/reservation_info_list_item.dart';
import 'package:wheere/view_model/type/reservation_data.dart';

class ReservationInfoList extends StatelessWidget {
  final List<ReservationData> reservationDataList;
  final void Function(ReservationData) onTap;
  final ScrollController scrollController = ScrollController();
  final void Function() deleteReservation;

  ReservationInfoList({
    Key? key,
    required this.reservationDataList,
    required this.onTap,
    required this.deleteReservation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.backGroundSubColor,
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
      ),
      child: Column(
        children: [
          ListView.separated(
            controller: scrollController,
            shrinkWrap: true,
            itemCount: reservationDataList.length,
            itemBuilder: (BuildContext context, int index) {
              ReservationData reservationData = reservationDataList[index];
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: kPaddingLargeSize,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onTap(reservationData),
                    child: ReservationInfoListItem(
                      bNo: reservationData.bNo,
                      rDate: reservationData.rDate,
                      sStationName: reservationData.sStationName,
                      sStationTime: reservationData.sStationTime,
                      eStationName: reservationData.eStationName,
                      eStationTime: reservationData.eStationTime,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => DottedBorder(
              color: CustomColor.itemMainColor,
              strokeWidth: kLineSmallSize,
              radius: Radius.zero,
              padding: EdgeInsets.zero,
              dashPattern: const [8, 4],
              child: Container(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 0.0),
            child: CustomOutlinedButton(
              onPressed: deleteReservation,
              text: "예약 취소",
              color: CustomColor.pointColor,
            ),
          ),
        ],
      ),
    );
  }
}
