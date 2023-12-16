import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/room_chat/domain/usecases/get_list_message_chat_room_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

part 'list_media_cubit.freezed.dart';
part 'list_media_state.dart';

@Injectable()
class ListMediaCubit extends Cubit<ListMediaState> {
  late final GetListMessageChatRoomUseCase _getListMessageChatRoomUseCase;
  ListMediaCubit(this._getListMessageChatRoomUseCase)
      : super(const ListMediaState.initial());

  Future<void> getListMessageMedia(String roomId) async {
    try {
      emit(state.copyWith(isLoading: true, roomId: roomId));
      final listMessageResponse =
          await _getListMessageChatRoomUseCase.executeList(
              request: GetListRoomMessageParam(chatRoomId: roomId, limit: 100));

      if (listMessageResponse.netData != null) {
        final listFile = listMessageResponse.netData?.where((element) {
          return element.type == MessageType.file;
        }).toList();
        final listVideo = listMessageResponse.netData?.where((element) {
          return element.type == MessageType.video;
        }).toList();
        final listImage = listMessageResponse.netData?.where((element) {
          return element.type == MessageType.image;
        }).toList();

        emit(state.copyWith(
          listFiles: listFile ?? [],
          listVideos: listVideo ?? [],
          listPhotos: listImage ?? [],
        ));
      }

      emit(state.copyWith(isLoading: false));
    } on AppException catch (e) {
      emit(state.copyWith(isLoading: false));
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }
}
