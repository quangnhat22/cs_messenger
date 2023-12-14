import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'edit_group_state.dart';
part 'edit_group_cubit.freezed.dart';

@Injectable()
class EditGroupCubit extends Cubit<EditGroupState> {
  EditGroupCubit() : super(EditGroupState.initial());
}
