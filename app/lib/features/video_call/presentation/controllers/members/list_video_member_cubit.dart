import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/video_call/domain/usecases/get_list_member_video_call_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

part 'list_video_member_state.dart';
part 'list_video_member_cubit.freezed.dart';

@Injectable()
class ListVideoMemberCubit extends Cubit<ListVideoMemberState> {
  late final GetListMemberVideoCallUseCase _getListMemberVideoCallUseCase;

  ListVideoMemberCubit(this._getListMemberVideoCallUseCase)
      : super(const ListVideoMemberState.initial());

  Future<void> getListMemberVideoCall(String chatRoomId) async {
    try {
      emit(state.copyWith(isLoading: true, isError: false));
      final listMembersResponse = await _getListMemberVideoCallUseCase
          .executeList(request: GetVideoCallTokenParam(chatRoomId: chatRoomId));
      if (listMembersResponse.netData != null) {
        emit(state.copyWith(
            listMembers: listMembersResponse.netData!, isLoading: false));
      }
    } on AppException catch (e) {
      emit(state.copyWith(isLoading: false, isError: true));
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }

  Future<void> refreshMemberVideoCall() async {
    try {
      emit(state.copyWith(isLoading: true, isError: false));
      final listMembersResponse =
          await _getListMemberVideoCallUseCase.executeList();
      if (listMembersResponse.netData != null) {
        emit(state.copyWith(
            listMembers: listMembersResponse.netData!, isLoading: false));
      }
    } on AppException catch (e) {
      emit(state.copyWith(isLoading: false, isError: true));
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }
}
