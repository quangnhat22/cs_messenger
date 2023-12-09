import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'list_selected_friend_state.dart';
part 'list_selected_friend_cubit.freezed.dart';

@Injectable()
class ListSelectedFriendCubit extends Cubit<ListSelectedFriendState> {
  ListSelectedFriendCubit() : super(const ListSelectedFriendState.initial());

  void selectedMemberChanged(UserModel member) {
    final existingMember = (state.selectedMembers).firstWhere(
      (element) => element.id == member.id,
      orElse: () => UserModel.empty,
    );
    if (existingMember.id == UserModel.empty.id) {
      emit(state.copyWith(
        selectedMembers: [...state.selectedMembers, member],
      ));
    } else {
      List<UserModel> newSelectedMember = state.selectedMembers
          .where((element) => element.id != member.id)
          .toList();
      emit(state.copyWith(
        selectedMembers: [...newSelectedMember],
      ));
    }
  }
}
