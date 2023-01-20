import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/payment_view_model.dart';
import 'package:wheere/view_model/type/types.dart';

class PaymentView extends StatefulWidget {
  final PaymentViewModel paymentViewModel;

  const PaymentView({Key? key, required this.paymentViewModel})
      : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late final PaymentViewModel _paymentViewModel = widget.paymentViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        title: "예약하기",
        leading: BackIconButton(
          onPressed: () => _paymentViewModel.navigatePop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingLargeSize),
          child: Container(
            color: CustomColor.backgroundMainColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "정보 확인",
                  style: kTextMainStyleLarge,
                ),
                const SizedBox(height: kPaddingLargeSize),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _paymentViewModel.reservationInfoList,
                ),
                const Text(
                  "결제 수단",
                  style: kTextMainStyleLarge,
                ),
                const SizedBox(height: kPaddingLargeSize),
                CustomRadioListTitle<Payment>(
                  value: Payment.kakaoPay,
                  groupValue: _paymentViewModel.payment,
                  title: '카카오페이',
                  onChanged: _paymentViewModel.changePayment,
                ),
                const SizedBox(height: kPaddingMiddleSize),
                CustomRadioListTitle<Payment>(
                  value: Payment.onSite,
                  groupValue: _paymentViewModel.payment,
                  title: '현장 결제',
                  onChanged: _paymentViewModel.changePayment,
                ),
                const SizedBox(height: kPaddingMiddleSize),
                const Text(
                  "결제 금액",
                  style: kTextMainStyleLarge,
                ),
                const SizedBox(height: kPaddingMiddleSize),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${_paymentViewModel.routeDTO.price} 원",
                      style: kTextMainStyleLarge,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                const SizedBox(height: kPaddingMiddleSize),
                CustomOutlinedButton(
                  onPressed: () => _paymentViewModel.makeReservation(context),
                  text: "결제하기",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
