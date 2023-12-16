import 'package:app/components/features/skeleton/list_skeletion.dart';
import 'package:app/features/room_chat/presentation/media/controllers/list_media/list_media_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return Container();
      },
    );
  }
}
