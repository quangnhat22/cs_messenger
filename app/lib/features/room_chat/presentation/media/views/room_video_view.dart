import 'package:app/components/features/message/image_gallery.dart';
import 'package:app/components/features/message/widgets/video_message.dart';
import 'package:app/components/features/skeleton/list_skeletion.dart';
import 'package:app/features/room_chat/presentation/media/controllers/list_media/list_media_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RoomVideoView extends StatelessWidget {
  const RoomVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    final widthSscreen = MediaQuery.sizeOf(context).width;

    return BlocBuilder<ListMediaCubit, ListMediaState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const ListSkeleton();
        }
        return GridView.builder(
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
          ),
          itemBuilder: (BuildContext s, int index) {
            return VideoMessage(
              currentUserId: '',
              message: state.listVideos[index] as VideoMessageModel,
              messageWidth: widthSscreen ~/ 3,
            );
          },
          itemCount: state.listVideos.length,
        );
      },
    );
  }
}
