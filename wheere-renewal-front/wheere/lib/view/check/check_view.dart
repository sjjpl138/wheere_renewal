import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/check_view_model.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view_model/type/types.dart';

class CheckView extends StatefulWidget {
  final CheckViewModel checkViewModel;
  final ReservationList reservationList;

  const CheckView(
      {Key? key, required this.checkViewModel, required this.reservationList})
      : super(key: key);

  @override
  State<CheckView> createState() => _CheckViewState();
}

class _CheckViewState extends State<CheckView>
    with AutomaticKeepAliveClientMixin {
  late final ReservationList _reservationList = widget.reservationList;
  late final CheckViewModel _checkViewModel = widget.checkViewModel;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("checkView is created");
    return Scaffold(
      body: Container(
        color: CustomColor.backgroundMainColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "예약확인",
                    style: kTextMainStyleLarge,
                  ),
                  const Spacer(),
                  CustomDropDownButton(
                    value: _checkViewModel.order,
                    items: _checkViewModel.orderList,
                    onChanged: (value) => _checkViewModel.onOrderChanged(value),
                  ),
                  const SizedBox(width: kPaddingSmallSize),
                  CustomDropDownButton(
                    value: _checkViewModel.rState,
                    items: _checkViewModel.rStateList,
                    onChanged: (value) =>
                        _checkViewModel.onRStateChanged(value),
                  ),
                ],
              ),
              const SizedBox(height: kPaddingMiddleSize),
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  _checkViewModel.scrollNotification(notification);
                  return false;
                },
                child: Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _reservationList.reservationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      ReservationDTO reservation =
                          _reservationList.reservationList[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: kPaddingLargeSize,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: CustomColor.backGroundSubColor,
                              borderRadius:
                                  BorderRadius.circular(kBorderRadiusSize),
                              border: Border.all(
                                  width: 2.0, color: CustomColor.itemSubColor)),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () => _checkViewModel
                                    .navigateToBusCurrentInfoPage(
                                  context,
                                  reservation,
                                ),
                                child: ReservationInfo(
                                  bNo: reservation.bNo,
                                  rDate: reservation.rDate,
                                  sStationName: reservation.sStationName,
                                  sStationTime: reservation.sTime,
                                  eStationName: reservation.eStationName,
                                  eStationTime: reservation.eTime,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  width:
                      _checkViewModel.isMoreRequesting ? kPaddingLargeSize : 0,
                  height:
                      _checkViewModel.isMoreRequesting ? kPaddingLargeSize : 0,
                  color: Colors.transparent,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: CustomColor.itemSubColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
