import 'dart:io';

import 'package:app/components/features/message/widgets/file_message.dart';
import 'package:app/components/features/skeleton/list_skeletion.dart';
import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/media/controllers/list_media/list_media_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:utilities/utilities.dart';

@RoutePage()
class RoomFileView extends StatelessWidget {
  const RoomFileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListMediaCubit, ListMediaState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const ListSkeleton();
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizeExt.of.majorPaddingScale(4),
          ),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async => await _onTapFileCard(
                    state.listFiles[index] as FileMessageModel),
                child: Card(
                  child: FileMessage(
                    message: state.listFiles[index] as FileMessageModel,
                    currentUserId: '',
                  ),
                ),
              );
            },
            itemCount: state.listFiles.length,
          ),
        );
      },
    );
  }

  Future<void> _onTapFileCard(FileMessageModel message) async {
    try {
      AppLoadingOverlayWidget.show();
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          await file.writeAsBytes(bytes);
        }
      }

      await OpenFilex.open(localPath);
    } catch (e) {
      Logs.e(e);
    } finally {
      AppLoadingOverlayWidget.dismiss();
    }
  }
}
