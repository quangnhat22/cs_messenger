import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_add_new_contact/controllers/search_input_bloc.dart';
import 'package:app/features/friend/presentation/friend_add_new_contact/widgets/add_new_contact_card_search_widget.dart';
import 'package:app/features/friend/presentation/friend_info/pages/friend_info_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class FriendAddNewContactPage extends StatelessWidget {
  const FriendAddNewContactPage({super.key});

  void _handleDoneButton(BuildContext context) {
    // context.router.push(const FriendInfoRoute());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchInputBloc>(),
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget()
              .setTextTitle(R.strings.addNewContact)
              .setBackgroundColor(Colors.transparent)
              .build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
      child: Column(
        children: <Widget>[
          const AddNewContactCardSearchWidget(),
          SizedBox(
            height: AppSizeExt.of.majorScale(4),
          ),
          Expanded(
            child: Card(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(
                  AppSizeExt.of.majorPaddingScale(2),
                ),
                // child: const FriendInfoPage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
