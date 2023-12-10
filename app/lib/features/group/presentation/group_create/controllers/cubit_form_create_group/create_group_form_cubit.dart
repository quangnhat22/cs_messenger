import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'create_group_form_state.dart';
part 'create_group_form_cubit.freezed.dart';

@Injectable()
class CreateGroupFormCubit extends Cubit<CreateGroupFormState> {
  CreateGroupFormCubit() : super(const CreateGroupFormState.initial());

  void friendInvitedChanged(List<UserModel> friends) {
    emit(state.copyWith(members: [...state.members ?? [], ...friends]));
  }

  void removeMember(String userId) {
    emit(state.copyWith(
        members:
            state.members?.where((element) => element.id != userId).toList()));
  }

  void groupAvatarChanged(String url) {
    emit(state.copyWith(groupImage: url));
  }

  void groupNameChanged(String name) {
    emit(state.copyWith(groupName: name));
  }
}
