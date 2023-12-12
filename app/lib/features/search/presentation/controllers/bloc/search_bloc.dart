import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/features/search/domain/usecases/search_uc.dart';
import 'package:app/features/user/domain/usecases/request/sent_request_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

@Injectable()
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  late final SearchUseCase _searchUseCase;
  late final SentRequestUseCase _sentRequestUseCase;

  SearchBloc(this._searchUseCase, this._sentRequestUseCase)
      : super(const _Initial()) {
    on<SearchEvent>((event, emit) async {
      await event.map(
        inputChanged: (event) async => await _inputChanged(event, emit),
        sendFriendRequest: (event) async =>
            await _sendFriendRequest(event, emit),
      );
    },
        transformer:
            debounce(Duration(milliseconds: AppConstants.timeDebounceSearch)));
  }

  Future<void> _inputChanged(event, Emitter<SearchState> emit) async {
    try {
      if (event.query != null && event.query!.isNotEmpty) {
        final response = await _searchUseCase.executeObj(
            request: SearchParam(query: event?.query));
        emit(state.copyWith(
          searchResult: response.netData,
        ));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _sendFriendRequest(
      SearchSendFriendRequest event, Emitter<SearchState> emit) async {
    try {
      AppLoadingOverlayWidget.show();
      await _sentRequestUseCase.executeObj(
          request: SentRequestParam(
        userId: event.userId,
      ));
      AppSnackBarWidget()
          .setLabelText(R.strings.sendRequestSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();
      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (_) {
            AppDefaultDialogWidget()
                .setTitle(R.strings.error)
                .setContent(R.strings.sendRequestFail)
                .setAppDialogType(AppDialogType.error)
                .setNegativeText(R.strings.close)
                .setPositiveText(R.strings.confirm)
                .buildDialog(AppKeys.navigatorKey.currentContext!)
                .show();
          }).detected();
    }
  }

  EventTransformer<E> debounce<E>(Duration duration) {
    return (events, mapper) {
      return events.debounce(duration).switchMap(mapper);
    };
  }
}
