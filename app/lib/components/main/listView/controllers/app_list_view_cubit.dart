import 'package:app/configs/exts/app_exts.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utilities/utilities.dart';

part 'app_list_view_cubit.freezed.dart';
part 'app_list_view_state.dart';

abstract class AppListViewCubit<BM extends BaseModel>
    extends Cubit<AppListViewState<BM>> {
  AppListViewCubit() : super(AppListViewState<BM>.initial()) {
    initFetch();
  }

  AppParam _appParam = AppParam();

  Future<AppListResultModel<BM>> onCall(AppParam appParam);

  void initFetch() async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await onCall(_appParam);

      emit(state.copyWith(
        data: [...response.netData ?? List.empty()],
        total: response.total,
        hasMore: response.hasMore,
        appException: null,
        isLoading: false,
      ));

      Logs.i(
          'AppListWidget Init Call: Data length ${state.data.length} --- total: ${state.total}');
    } on AppException catch (e) {
      AppExceptionExt(
        appException: e,
        onError: (_) {
          emit(state.copyWith(appException: e, isLoading: false));
        },
      ).detected();
    }
  }

  Future<void> onRefreshCall() async {
    try {
      _appParam = _appParam.copyWith(page: 1);
      final response = await onCall(_appParam);

      emit(state.copyWith(
        data: [...response.netData ?? List.empty()],
        total: response.total,
        hasMore: response.hasMore,
        appException: null,
      ));

      Logs.i(
          'AppListWidget Init Call: Data length ${state.data.length} --- total: ${state.total}');
    } on AppException catch (e) {
      AppExceptionExt(
        appException: e,
        onError: (_) {
          emit(state.copyWith(appException: e));
        },
      ).detected();
    }
  }

  Future<void> onRefreshCallWithLoading() async {
    emit(state.copyWith(isLoading: true));
    await onRefreshCall();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> onLoadMoreCall() async {
    try {
      _appParam = _appParam.copyWith(page: _appParam.page + 1);
      final response = await onCall(_appParam);

      emit(state.copyWith(
        data: [...state.data, ...response.netData ?? List.empty()],
        total: response.total,
        hasMore: response.hasMore,
        appException: null,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(appException: e));
    }
  }
}
