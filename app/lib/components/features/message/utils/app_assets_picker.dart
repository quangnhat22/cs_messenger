import 'dart:io';

import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class AppAssetsPicker {
  AppAssetsPicker._();

  static Future<AssetEntity?>? pickImageFromGallery(BuildContext context,
      {int limit = 1}) async {
    try {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: limit,
          requestType: RequestType.image,
          textDelegate: const EnglishAssetPickerTextDelegate(),
        ),
      );
      if (result == null) return null;

      final file = await result[0].file;

      final checkSize = await checkSizeFile(file);

      return checkSize ? result[0] : null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<AssetEntity?>? pickImageFromCamera(BuildContext context) async {
    try {
      final AssetEntity? result = await CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          textDelegate: EnglishCameraPickerTextDelegate(),
        ),
      );
      final file = await result?.file;
      final checkSize = await checkSizeFile(file);
      return checkSize ? result : null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<String?>? pickVideo(BuildContext context,
      {int limit = 1}) async {
    try {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: limit,
          requestType: RequestType.video,
        ),
      );

      if (result == null) return null;

      final file = await result[0].file;

      if (file == null) return null;

      final checkSize = await checkSizeFile(file);

      return checkSize ? file.path : null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // static Future<String?>? pickFile(BuildContext context) async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles();
  //     if (result != null) {
  //       return result.paths[0];
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  static Future<bool> checkSizeFile(File? file) async {
    if (file == null) return false;
    final sizeInBytes = await file.length();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < AppConstants.sizeMbFileLimit) {
      return true;
    }
    AppSnackBarWidget()
        .setLabelText(
            R.strings.fileLimitSize(AppConstants.sizeMbFileLimit.toString()))
        .setAppSnackBarType(AppSnackBarType.informMessage)
        .setAppSnackBarStatus(AppSnackBarStatus.error)
        .showSnackBar();
    return false;
  }

  static Future<double> getSize(File? file) async {
    if (file == null) return 0;
    final sizeInBytes = await file.length();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return double.parse(sizeInMb.toStringAsFixed(1));
  }
}
