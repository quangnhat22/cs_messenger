part of 'base_raw.dart';

@freezed
@HiveType(typeId: 0)
class UserRaw extends BaseRaw<UserModel> with _$UserRaw {
  UserRaw._();

  factory UserRaw({
    @HiveField(0) required String id,
    @HiveField(1) String? name,
    @HiveField(2) String? email,
    @HiveField(3) String? avatar,
    @HiveField(4) String? phone,
    @HiveField(5) String? gender,
    @HiveField(6) int? birthday,
    @HiveField(7) String? bio,
    @Default(0) @JsonKey(name: "friend_common") int? friendCommon,
    @Default(0) @JsonKey(name: "group_common") int? groupCommon,
    RelationRaw? relation,
  }) = _UserRaw;

  factory UserRaw.fromJson(Map<String, Object?> json) =>
      _$UserRawFromJson(json);

  @override
  UserModel raw2Model() {
    return UserModel(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      phone: phone,
      gender: GenderType.convertStringToGenderType(gender),
      birthday: birthday != null
          ? DateTimeExt.convertTimeStampToDateTime(birthday!)
          : null,
      bio: bio,
      relation: relation?.raw2Model(),
      friendCommon: friendCommon,
      groupCommon: groupCommon,
    );
  }
}
