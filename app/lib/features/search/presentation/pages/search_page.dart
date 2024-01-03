import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/search/presentation/controllers/bloc/search_bloc.dart';
import 'package:app/features/search/presentation/widgets/search_group_item_widget.dart';
import 'package:app/features/search/presentation/widgets/search_list_result_widget.dart';
import 'package:app/features/search/presentation/widgets/search_message_item_widget.dart';
import 'package:app/features/search/presentation/widgets/search_user_item_widget.dart';
import 'package:auto_route/auto_route.dart';
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
    return BlocConsumer<SearchBloc, SearchState>(
      listenWhen: (prev, current) =>
          prev.isSentFriendRequestSuccess != current.isSentFriendRequestSuccess,
      listener: (context, state) async {
        if (state.isSentFriendRequestSuccess) {
          AppSnackBarWidget()
              .setLabelText(R.strings.sendRequestSuccess)
              .setAppSnackBarType(AppSnackBarType.informMessage)
              .setAppSnackBarStatus(AppSnackBarStatus.success)
              .showSnackBarWithContext(context);

          context
              .read<SearchBloc>()
              .add(const SearchSendFriendRequestSuccess());

          await context.router.pop();
        }
      },
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
                    totalResult: state.totalResults,
                    itemBuilder: (BuildContext context, int index) =>
                        SearchUserItemWidget(
                      user: state.searchResult?.users?[index],
                    ),
                  ),
                if (state.searchResult?.recommendedFriend != null &&
                    state.searchResult!.recommendedFriend!.isNotEmpty)
                  SearchListResultWidget(
                    title: R.strings.recommendedUser,
                    itemCount:
                        state.searchResult?.recommendedFriend?.length ?? 0,
                    totalResult: state.totalResults,
                    itemBuilder: (BuildContext context, int index) =>
                        SearchUserItemWidget(
                      user: state.searchResult?.recommendedFriend?[index],
                    ),
                  ),
                if (state.searchResult?.messages != null &&
                    state.searchResult!.messages!.isNotEmpty)
                  SearchListResultWidget(
                    title: R.strings.messenger,
                    itemCount: state.searchResult?.messages?.length ?? 0,
                    totalResult: state.totalResults,
                    itemBuilder: (BuildContext context, int index) =>
                        SearchMessageItemWidget(
                      chatRoom: state.searchResult?.messages?[index],
                    ),
                  ),
                if (state.searchResult?.groups != null &&
                    state.searchResult!.groups!.isNotEmpty)
                  SearchListResultWidget(
                    title: R.strings.groups,
                    itemCount: state.searchResult?.groups?.length ?? 0,
                    totalResult: state.totalResults,
                    itemBuilder: (BuildContext context, int index) =>
                        SearchGroupItemWidget(
                      group: state.searchResult?.groups?[index],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
