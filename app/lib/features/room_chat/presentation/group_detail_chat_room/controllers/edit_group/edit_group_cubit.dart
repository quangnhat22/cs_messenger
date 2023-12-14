import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/group/domain/usecases/edit_group_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

part 'edit_group_state.dart';
part 'edit_group_cubit.freezed.dart';

@Injectable()
class EditGroupCubit extends Cubit<EditGroupState> {
  late final EditGroupUseCase _editGroupUseCase;

  EditGroupCubit(this._editGroupUseCase)
      : super(const EditGroupState.initial());

  Future<void> editGroup() async {
    try {
      await _editGroupUseCase.executeObj(
          request: const EditGroupParam(name: '123'));
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.d(e);
          }).detected();
    }
  }
}
