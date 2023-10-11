import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:flutter/material.dart';

class UIKitDemoPage extends StatelessWidget {
  const UIKitDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setBackgroundColor(Colors.white)
        .setAppBar(
          AppBarWidget()
              .setCenterTitle(true)
              .setTextTitle('Hello UIKIT')
              .build(context),
        )
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return Container();
    // return Column(
    //   children: <Widget>[
    //     AppButtonOutlineWidget().setButtonText('OpenDialog').setOnPressed(() {
    //       AppDefaultDialogWidget()
    //           .setAppDialogType(AppDialogType.confirm)
    //           .setTitle('Hello')
    //           .setContent('Test dialog')
    //           .setPositiveText('Ok')
    //           .setOnPositive(() {})
    //           .setNegativeText('Close')
    //           .buildDialog(context)
    //           .show();
    //     }).build(context),
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: AppButtonTextWidget()
    //           .setButtonText('HELLO')
    //           .setIsDisable(false)
    //           .setOnPressed(() {})
    //           .build(context),
    //     )
    //   ],
    // );
  }
}
