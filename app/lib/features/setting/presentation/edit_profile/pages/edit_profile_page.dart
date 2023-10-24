import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setAppBar(_appBar(context))
        .setBody(_body(context))
        .build(context);
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBarWidget().setTextTitle('Edit Profile').setActions([
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.check_outlined),
      )
    ]).build(context);
  }

  Widget _body(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(1)),
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                  height: 120,
                  width: 120,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
