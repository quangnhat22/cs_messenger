import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

class VideoCallDialogExts {
  static void showPublishDialog(Future<void> Function()? onPositive) {
    AppDefaultDialogWidget()
        .setAppDialogType(AppDialogType.confirm)
        .setTitle('Publish')
        .setContent('Would you like to publish your Camera & Mic ?')
        .setNegativeText('NO')
        .setPositiveText('YES')
        .setOnPositive(() async {
          try {
            await onPositive?.call();
          } catch (e) {
            Logs.d('could not publish video: $e');
            // await context.showErrorDialog(error);
          }
        })
        .buildDialog(AppKeys.navigatorKey.currentContext!)
        .show();
  }

  static void showUnPublishDialog(Future<void> Function()? onPositive) {
    AppDefaultDialogWidget()
        .setAppDialogType(AppDialogType.confirm)
        .setTitle('UnPublish')
        .setContent('Would you like to un-publish your Camera & Mic ?')
        .setNegativeText('NO')
        .setPositiveText('YES')
        .setOnPositive(() async {
          try {
            await onPositive?.call();
            await getIt<AppRouter>().pop();
          } catch (e) {
            Logs.d('could not publish video: $e');
            // await context.showErrorDialog(error);
          }
        })
        .buildDialog(AppKeys.navigatorKey.currentContext!)
        .show();
  }
}

extension VideCallExts on BuildContext {
  //DONE
  Future<bool?> showPublishDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const Text('Publish'),
          content: const Text('Would you like to publish your Camera & Mic ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('NO'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('YES'),
            ),
          ],
        ),
      );

  Future<bool?> showPlayAudioManuallyDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const Text('Play Audio'),
          content: const Text(
              'You need to manually activate audio PlayBack for iOS Safari !'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Ignore'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Play Audio'),
            ),
          ],
        ),
      );

  //DONE
  Future<bool?> showUnPublishDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const Text('UnPublish'),
          content:
              const Text('Would you like to un-publish your Camera & Mic ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('NO'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('YES'),
            ),
          ],
        ),
      );

  Future<void> showErrorDialog(dynamic exception) => showDialog<void>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: Text(exception.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            )
          ],
        ),
      );

  Future<bool?> showDisconnectDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: Text(R.strings.disconnect),
          content: Text(R.strings.areYouSureDisconnect),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(R.strings.close),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(R.strings.confirm),
            ),
          ],
        ),
      );

  Future<bool?> showReconnectDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: Text(R.strings.reconnect),
          content: Text(R.strings.thisWillForceReconnect),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(R.strings.close),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(R.strings.reconnect),
            ),
          ],
        ),
      );

  Future<void> showReconnectSuccessDialog() => showDialog<void>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: Text(R.strings.reconnect),
          content: Text(R.strings.reconnectSuccess),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(R.strings.confirm),
            ),
          ],
        ),
      );

  Future<bool?> showSendDataDialog() => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const Text('Send data'),
          content: const Text(
              'This will send a sample data to all participants in the room'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Send'),
            ),
          ],
        ),
      );

  Future<bool?> showDataReceivedDialog(String data) => showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const Text('Received data'),
          content: Text(data),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('OK'),
            ),
          ],
        ),
      );

  Future<bool?> showRecordingStatusChangedDialog(bool isActiveRecording) =>
      showDialog<bool>(
        context: this,
        builder: (ctx) => AlertDialog(
          title: const Text('Room recording reminder'),
          content: Text(isActiveRecording
              ? 'Room recording is active.'
              : 'Room recording is stopped.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('OK'),
            ),
          ],
        ),
      );
}

enum SimulateScenarioResult {
  signalReconnect,
  nodeFailure,
  migration,
  serverLeave,
  switchCandidate,
  clear,
  e2eeKeyRatchet,
  participantName,
  participantMetadata,
}
