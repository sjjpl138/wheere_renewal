import 'package:flutter/material.dart';
import 'package:wheere/view_model/search_view_model.dart';
import '../../styles/styles.dart';
import '../common/commons.dart';

class SearchView extends StatefulWidget {
  final SearchViewModel searchViewModel;

  const SearchView({Key? key, required this.searchViewModel}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with AutomaticKeepAliveClientMixin {
  late final SearchViewModel _searchViewModel = widget.searchViewModel;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("searchView is created");
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: CustomColor.backgroundMainColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "예약하기",
                  style: kTextMainStyleLarge,
                ),
                const SizedBox(height: kPaddingLargeSize),
                Row(
                  children: [
                    Flexible(
                      child: CustomDialogButton(
                        onPressed: () =>
                            _searchViewModel.searchStartPlaces(context),
                        labelText: "출발지",
                        text: _searchViewModel.sPlaceInfo?.placeName ?? "출발지",
                        prefixIcon: Icons.location_on_outlined,
                      ),
                    ),
                    const SizedBox(width: kPaddingLargeSize),
                    const Icon(
                      Icons.arrow_right_alt,
                      color: CustomColor.itemSubColor,
                    ),
                    const SizedBox(width: kPaddingLargeSize),
                    Flexible(
                      child: CustomDialogButton(
                        onPressed: () =>
                            _searchViewModel.searchEndPlaces(context),
                        labelText: "도착지",
                        text: _searchViewModel.ePlaceInfo?.placeName ?? "도착지",
                        prefixIcon: Icons.location_on,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kPaddingLargeSize),
                CustomDatePicker(
                  onDateTimeChanged:
                  _searchViewModel.onSearchDateChanged,
                  initDate: DateTime.now(), title: '탑승날짜',
                ),
                const SizedBox(height: kPaddingLargeSize),
                CustomOutlinedButton(
                  onPressed: () =>
                      _searchViewModel.searchRoutes(context, mounted),
                  text: "조회 하기",
                ),
                const SizedBox(height: kPaddingLargeSize),
                // TODO : 광고 베너 추가
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
