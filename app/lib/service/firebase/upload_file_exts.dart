import 'dart:io';

import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

enum TypeFile {
  images("images");

  const TypeFile(this.type);

  final String type;
}

class UploadFileExts {
  UploadFileExts._();

  static UploadTask? uploadFile(String filePath) {
    try {
      //get name for file by random time.
      String uniqueImageName = DateTime.now().microsecondsSinceEpoch.toString();
      // path for file in firestore
      Reference ref = FirebaseStorage.instance.ref();
      Reference refDirImage = ref.child(TypeFile.images.type);
      Reference refToUpload = refDirImage.child(uniqueImageName);

      UploadTask? uploadTask = refToUpload.putFile(File(filePath));

      return uploadTask;
    } catch (err) {
      Logs.e('Failed to pick image: $err');
      return null;
    }
  }

  static Future<String?> handleSnapShot(TaskSnapshot taskSnapshot) async {
    try {
      switch (taskSnapshot.state) {
        case TaskState.running:
          {
            final progress =
                100 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            AppLoadingOverlayWidget.show(message: progress.toString());
            return null;
          }
        case TaskState.paused:
          AppLoadingOverlayWidget.dismiss();
          Logs.e("upload image paused");
          return null;
        case TaskState.success:
          String path = await taskSnapshot.ref.getDownloadURL();
          AppLoadingOverlayWidget.dismiss();
          AppSnackBarWidget()
              .setLabelText(R.strings.uploadImageSuccess)
              .setAppSnackBarType(AppSnackBarType.informMessage)
              .setAppSnackBarStatus(AppSnackBarStatus.success)
              .showSnackBar();
          return path;
        case TaskState.canceled:
        case TaskState.error:
          AppLoadingOverlayWidget.dismiss();
          AppSnackBarWidget()
              .setLabelText(R.strings.updateProfileFail)
              .setAppSnackBarType(AppSnackBarType.informMessage)
              .setAppSnackBarStatus(AppSnackBarStatus.error)
              .showSnackBar();
          return null;
      }
    } catch (err) {
      Logs.e('Failed to pick image: $err');
      return null;
    }
  }
}
