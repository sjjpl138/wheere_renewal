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

class _SearchViewState extends State<SearchView> {
  late final SearchViewModel _searchViewModel = widget.searchViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: CustomColor.backgroundMainColor,
          child: Padding(
            padding: const EdgeInsets.all(kPaddingLargeSize),
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
                // TODO : CustomDialogButton onPressed 추가
                Row(
                  children: const [
                    Flexible(
                      child: CustomDialogButton(
                        onPressed: null,
                        labelText: "출발지",
                        text: "출발지",
                        prefixIcon: Icons.location_on_outlined,
                      ),
                    ),
                    SizedBox(width: kPaddingLargeSize),
                    Icon(
                      Icons.arrow_right_alt,
                      color: CustomColor.itemSubColor,
                    ),
                    SizedBox(width: kPaddingLargeSize),
                    Flexible(
                      child: CustomDialogButton(
                        onPressed: null,
                        labelText: "도착지",
                        text: "도착지",
                        prefixIcon: Icons.location_on,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kPaddingLargeSize),
                const CustomDialogButton(
                  onPressed: null,
                  labelText: "탑승 날짜",
                  text: "탑승 날짜",
                  prefixIcon: Icons.event_note,
                ),
                const SizedBox(height: kPaddingLargeSize),
                const CustomOutlinedButton(
                  onPressed: null,
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
}
