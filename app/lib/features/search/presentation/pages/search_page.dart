import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/search/presentation/controllers/bloc/search_bloc.dart';
import 'package:app/features/search/presentation/widgets/search_list_result_widget.dart';
import 'package:app/features/search/presentation/widgets/search_user_item_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setBackgroundColor(Theme.of(context).colorScheme.background)
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizeExt.of.majorPaddingScale(0),
              vertical: AppSizeExt.of.majorPaddingScale(0),
            ),
            child: Column(
              children: <Widget>[
                if (state.searchResult?.users != null &&
                    state.searchResult!.users!.isNotEmpty)
                  SearchListResultWidget(
                    title: R.strings.user,
                    itemCount: state.searchResult?.users?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) =>
                        SearchUserItemWidget(
                      user: state.searchResult?.users?[index],
                    ),
                  ),
                if (state.searchResult?.friends != null &&
                    state.searchResult!.friends!.isNotEmpty)
                  SearchListResultWidget(
                    title: R.strings.friends,
                    itemBuilder: (BuildContext context, int index) =>
                        const SearchUserItemWidget(),
                  ),
                if (state.searchResult?.groups != null &&
                    state.searchResult!.groups!.isNotEmpty)
                  SearchListResultWidget(
                    title: R.strings.groups,
                    itemBuilder: (BuildContext context, int index) =>
                        const SearchUserItemWidget(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
