import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

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
                            // if (await AppPermissionExt
                            //     .checkPermissionCamera()) {
                            //   final image = await pickImage(
                            //     Get.context ?? context,
                            //     field,
                            //     ImageSource.camera,
                            //     setOnChanged,
                            //   );
                            //   field.didChange(image);
                            //   Get.back();
                            // } else {
                            //   Get.back();
                            //   AppDialogGrantPermissionRequestWidget(
                            //           permissionName: R.strings.camera)
                            //       .build(Get.context ?? context);
                            // }
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
                            // if (await AppPermissionExt
                            //     .checkPermissionGallery()) {
                            //   final image = await pickImage(
                            //     Get.context ?? context,
                            //     field,
                            //     ImageSource.gallery,
                            //     setOnChanged,
                            //   );
                            //   field.didChange(image);
                            //   Get.back();
                            // } else {
                            //   Get.back();
                            //   AppDialogGrantPermissionRequestWidget(
                            //           permissionName: R.strings.gallery)
                            //       .build(Get.context ?? context);
                            // }
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

  Future<String?> pickImage(
    BuildContext context,
    FormFieldState<String?> field,
    // ImageSource source,
    void Function()? setSetOnChanged,
  ) async {
    // final picker = ImagePicker();
    // final pickedImage = await picker.pickImage(source: source);
    //
    // if (pickedImage != null) {
    //   field.didChange(pickedImage.path);
    //   setSetOnChanged!.call();
    //   return pickedImage.path;
    // }
    return null;
  }
}
