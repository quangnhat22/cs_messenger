part of 'base_raw.dart';

@freezed
class UserRaw extends BaseRaw<UserModel> with _$UserRaw {
  UserRaw._();

  factory UserRaw({
    required String id,
    String? name,
    String? email,
    String? avatar,
    String? phone,
    String? gender,
    int? birthday,
    String? bio,
    String? relation,
  }) = _UserRaw;

  factory UserRaw.fromJson(Map<String, Object?> json) =>
      _$UserRawFromJson(json);

  @override
  UserModel raw2Model() {
    return UserModel(
      id: id,
      name: name,
      avatar: avatar,
      phone: phone,
      gender: GenderType.convertStringToGenderType(gender),
      birthday: birthday != null
          ? DateTimeExt.convertTimeStampToDateTime(birthday!)
          : null,
      bio: bio,
      relation: RelationType.convertStringToRelationType(relation),
    );
  }
}
