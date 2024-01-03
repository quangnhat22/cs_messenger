import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/features/devices/presentation/list_device/controllers/device_list_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

class ListHistoryDeviceWidget extends StatelessWidget {
  const ListHistoryDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppListWidget<DeviceModel, AppListViewState<DeviceModel>,
        DeviceListCubit>(
      physics: const BouncingScrollPhysics(),
      childWidget: _buildCardDeviceItem,
    );
  }

  Widget _buildCardDeviceItem(
      BuildContext context, DeviceModel device, int index) {
    return AppCardWidget()
        .setLeading(device.os == 'android'
            ? const CircleAvatar(
                child: Icon(Icons.android),
              )
            : const CircleAvatar(
                child: Icon(Icons.smartphone_sharp),
              ))
        .setTitle(AppTextBodyLargeWidget().setText(device.model).build(context))
        .setSubtitle(AppTextBodyMediumWidget()
            .setText(DateTimeExt.dateTimeToDisplayHHmmddMMyyyy(
                dateTime: device.lastActive))
            .build(context))
        .setActions(
      [
        if (!device.isCurrentDevice)
          AppButtonOutlineWidget()
              .setPrefixIcon(Icon(
                Icons.delete_outline,
                color: Theme.of(context).colorScheme.error,
              ).build(context))
              .setBorderColor(Theme.of(context).colorScheme.errorContainer)
              .setOnPressed(() => _deleteDevice(context, device.id))
              .build(context)
      ],
    ).build(context);
  }

  void _deleteDevice(BuildContext context, String deviceId) {
    AppDefaultDialogWidget()
        .setTitle(R.strings.confirm)
        .setContent(R.strings.doYouWantDeleteDevice)
        .setAppDialogType(AppDialogType.error)
        .setPositiveText(R.strings.confirm)
        .setNegativeText(R.strings.close)
        .setOnPositive(() async {
          await context.read<DeviceListCubit>().deleteDevice(deviceId);
        })
        .buildDialog(context)
        .show();
  }
}
