import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view/search/search_view.dart';
import 'package:wheere/view_model/search_view_model.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (_) => SearchViewModel(),
      child: Consumer<SearchViewModel>(
        builder: (context, provider, child) => SearchView(
          searchViewModel: provider,
        ),
      ),
    );
  }
}
