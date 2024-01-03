import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/devices/presentation/list_device/controllers/device_list_cubit.dart';
import 'package:app/features/devices/presentation/list_device/widgets/list_history_device_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class ListDevicesPage extends StatelessWidget {
  const ListDevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DeviceListCubit>(),
      child: AppMainPageWidget()
          .setAppBar(
              AppBarWidget().setTextTitle(R.strings.devices).build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: AppSizeExt.of.majorPaddingScale(2),
          //     vertical: AppSizeExt.of.majorPaddingScale(3),
          //   ),
          //   child: AppTextTitleMediumWidget()
          //       .setText(R.strings.currentDevices)
          //       .setTextStyle(TextStyle(
          //         color: Theme.of(context).colorScheme.primary,
          //         fontWeight: FontWeight.bold,
          //       ))
          //       .build(context),
          // ),
          // SizedBox(
          //   height: AppSizeExt.of.majorScale(1),
          // ),
          // AppCardWidget()
          //     .setLeading(const CircleAvatar(
          //       child: Icon(Icons.android),
          //     ))
          //     .setTitle(
          //         AppTextBodyLargeWidget().setText('MI 9T').build(context))
          //     .setSubtitle(AppTextBodyMediumWidget()
          //         .setText('Android 13 - Current')
          //         .build(context))
          //     .build(context),
          SizedBox(
            height: AppSizeExt.of.majorScale(2),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizeExt.of.majorPaddingScale(2),
              vertical: AppSizeExt.of.majorPaddingScale(3),
            ),
            child: AppTextTitleMediumWidget()
                .setText(R.strings.activeSession)
                .setTextStyle(TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ))
                .build(context),
          ),
          SizedBox(
            height: AppSizeExt.of.majorScale(1),
          ),
          const Expanded(
            child: ListHistoryDeviceWidget(),
          ),
        ],
      ),
    );
  }
}
