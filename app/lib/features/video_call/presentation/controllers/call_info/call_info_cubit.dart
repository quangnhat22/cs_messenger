import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/video_call/domain/usecases/get_video_call_token_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:utilities/utilities.dart';

part 'call_info_cubit.freezed.dart';
part 'call_info_state.dart';

@Injectable()
class CallInfoCubit extends Cubit<CallInfoState> {
  late final GetVideoCallTokenUseCase _getVideoCallTokenUseCase;

  CallInfoCubit(this._getVideoCallTokenUseCase)
      : super(const CallInfoState.initial());

  @override
  Future<void> close() async {
    await state.room?.dispose();
    return super.close();
  }

  void initPage(String chatRoomId) {
    final room = Room();
    emit(state.copyWith(room: room, chatRoomId: chatRoomId));
  }

  Future<void> connectRoom(
      {LocalAudioTrack? audioTrack, LocalVideoTrack? videoTrack}) async {
    try {
      Future.delayed(const Duration(seconds: 5), () {
        emit(state.copyWith(callStatus: ConnectVideoCallStatus.connected));
      });
      // final tokenResponse = await _getVideoCallTokenUseCase.executeObj(
      //     request: GetVideoCallTokenParam(chatRoomId: state.chatRoomId));
      // final String? token = tokenResponse.netData?.token;
      // if (state.room != null && token != null) {
      //   // E2EEOptions? e2eeOptions;
      //   // if (args.e2ee && args.e2eeKey != null) {
      //   //   final keyProvider = await BaseKeyProvider.create();
      //   //   e2eeOptions = E2EEOptions(keyProvider: keyProvider);
      //   //   await keyProvider.setKey(args.e2eeKey!);
      //   // }
      //   await state.room!.connect(
      //     '',
      //     token,
      //     roomOptions: const RoomOptions(
      //       adaptiveStream: true,
      //       dynacast: true,
      //       defaultAudioPublishOptions:
      //           AudioPublishOptions(name: 'custom_audio_track_name'),
      //       defaultVideoPublishOptions: VideoPublishOptions(
      //         simulcast: true,
      //         videoCodec: 'VP8',
      //         backupVideoCodec: BackupVideoCodec(
      //           enabled: true,
      //         ),
      //       ),
      //       defaultScreenShareCaptureOptions: ScreenShareCaptureOptions(
      //           useiOSBroadcastExtension: true,
      //           params: VideoParameters(
      //               dimensions: VideoDimensionsPresets.h1080_169,
      //               encoding: VideoEncoding(
      //                 maxBitrate: 3 * 1000 * 1000,
      //                 maxFramerate: 15,
      //               ))),
      //       defaultCameraCaptureOptions: CameraCaptureOptions(
      //         maxFrameRate: 30,
      //         params: VideoParametersPresets.h720_169,
      //       ),
      //       // e2eeOptions: e2eeOptions,
      //     ),
      //     fastConnectOptions: FastConnectOptions(
      //       microphone: TrackOption(track: audioTrack),
      //       camera: TrackOption(track: videoTrack),
      //     ),
      //   );
      // }
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    } catch (e) {
      Logs.e(e);
    }
  }
}
