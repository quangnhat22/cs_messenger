part of 'create_group_form_cubit.dart';

@freezed
class CreateGroupFormState with _$CreateGroupFormState {
  const factory CreateGroupFormState.initial({
    String? groupImage,
    @Default("") String groupName,
    List<UserModel>? members,
  }) = _Initial;
}
