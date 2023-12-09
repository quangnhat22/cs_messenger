import 'dart:io';

import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:file_picker/file_picker.dart';
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

  static Future<AssetEntity?>? pickVideo(BuildContext context,
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

      final checkSize = await checkSizeFile(file);

      return checkSize ? result[0] : null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<PlatformFile?>? pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        final sizeInMb = result.files[0].size / (1000 * 1024);
        final checkFileSize = checkLimitSize(sizeInMb);
        return checkFileSize ? result.files.single : null;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> checkSizeFile(File? file) async {
    if (file == null) return false;
    final sizeInBytes = await file.length();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return checkLimitSize(sizeInMb);
  }

  static bool checkLimitSize(double sizeInMb) {
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
