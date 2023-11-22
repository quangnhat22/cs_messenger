import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class AppAssetsPicker {
  AppAssetsPicker._();

  static Future<String?>? pickImageFromGallery(BuildContext context,
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

      if (file == null) return null;

      final filePath = file.path;

      return filePath;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<String?>? pickImageFromCamera(BuildContext context) async {
    try {
      final AssetEntity? result = await CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          textDelegate: EnglishCameraPickerTextDelegate(),
        ),
      );
      if (result == null) return null;

      final file = await result.file;

      if (file == null) return null;

      final filePath = file.path;

      return filePath;
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

      final filePath = file.path;

      return filePath;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<String?>? pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        return result.paths[0];
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
