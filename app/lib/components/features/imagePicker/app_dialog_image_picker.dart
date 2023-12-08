import 'dart:io';

import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

class AppDialogImagePickerWidget extends StatelessWidget {
  const AppDialogImagePickerWidget({
    Key? key,
    this.setOnChanged,
  }) : super(key: key);

  final void Function()? setOnChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              getIt<AppRouter>().pop();
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: AppSizeExt.of.majorScale(16 / 4),
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: EdgeInsets.symmetric(
              horizontal: AppSizeExt.of.majorPaddingScale(4),
              vertical: AppSizeExt.of.majorPaddingScale(2),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(3)),
            ),
            child: Container(
              padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppSizeExt.of.majorScale(4)),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final file =
                                await AppAssetsPicker.pickImageFromCamera(
                                    context);
                            await getIt<AppRouter>().pop<File>(file);
                          },
                          child: SizedBox(
                            height: AppSizeExt.of.majorPaddingScale(12),
                            child: Center(
                              child: AppTextBodyLargeWidget()
                                  .setText(R.strings.takeAPhoto)
                                  .setColor(
                                      Theme.of(context).colorScheme.primary)
                                  .build(context),
                            ),
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () async {
                            final file =
                                await AppAssetsPicker.pickImageFromGallery(
                                    context);
                            await getIt<AppRouter>().pop<File>(file);
                          },
                          child: SizedBox(
                            height: AppSizeExt.of.majorPaddingScale(12),
                            child: Center(
                              child: AppTextBodyLargeWidget()
                                  .setText(R.strings.pickFromGallery)
                                  .setColor(
                                      Theme.of(context).colorScheme.primary)
                                  .build(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizeExt.of.majorScale(4)),
                  InkWell(
                    onTap: () {
                      getIt<AppRouter>().pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(
                              AppSizeExt.of.majorScale(4))),
                      height: AppSizeExt.of.majorPaddingScale(12),
                      child: Center(
                        child: AppTextBodyLargeWidget()
                            .setText(R.strings.cancel)
                            .setColor(Theme.of(context).colorScheme.error)
                            .build(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
