import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view_model/type/types.dart';
import 'service_info_item.dart';

class ServiceInfo extends StatelessWidget {
  final List<ServiceInfoData> serviceInfoDataList;
  late final List<Widget> serviceInfoList;

  ServiceInfo({
    super.key,
    required this.serviceInfoDataList,
  }) {
    serviceInfoList = serviceInfoDataList.map((e) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServiceInfoItem(
            prefixIcon: e.prefixIcon,
            title: e.title,
            contents: e.contents,
          ),
          const SizedBox(height: kPaddingMiddleSize),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kPaddingLargeSize,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.backGroundSubColor,
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingMiddleSize),
          child: Column(
            children: serviceInfoList,
          ),
        ),
      ),
    );
  }
}
