import 'package:flutter/material.dart';
import 'package:wheere/view_model/select_view_model.dart';
import '../../styles/styles.dart';
import '../common/commons.dart';

class SelectView extends StatefulWidget {
  final SelectViewModel selectViewModel;

  const SelectView({Key? key, required this.selectViewModel}) : super(key: key);

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> with TickerProviderStateMixin {
  late final SelectViewModel _selectViewModel = widget.selectViewModel;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: _selectViewModel.tabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        title: "조회하기",
        leading: BackIconButton(
          onPressed: () => _selectViewModel.navigatePop(context),
        ),
      ),
      body: Container(
        color: CustomColor.backgroundMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kPaddingMiddleSize),
            Container(
              color: CustomColor.backGroundSubColor,
              child: TabBar(
                isScrollable: true,
                controller: _tabController,
                tabs: _selectViewModel.tabs.keys.toList(),
                indicatorColor: CustomColor.itemSubColor,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: CustomColor.textMainColor,
                unselectedLabelColor: CustomColor.textMainColor,
                labelStyle: kTextMainStyleSmall,
              ),
            ),
            const SizedBox(height: kPaddingMiddleSize),
            Padding(
              padding: const EdgeInsets.only(bottom: kPaddingMiddleSize),
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColor.backGroundSubColor,
                  borderRadius: BorderRadius.circular(kBorderRadiusSize),
                ),
                child: Row(
                  children: const [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: kPaddingMiddleSize,
                        ),
                        child: CustomListItem(
                          bNo: '버스 번호',
                          sStation: '출발 정류장',
                          eStation: '도착 정류장',
                          leftSeats: '남은 좌석',
                        ),
                      ),
                    ),
                    // TODO : Visibility가 아닌 다른 방식으로 같은 공간 확보 필요
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: false,
                      child: CustomOutlinedMiniButton(
                        onPressed: null,
                        text: "정렬",
                      ),
                    ),
                    SizedBox(width: kPaddingMiddleSize),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _selectViewModel.tabs.values.toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
