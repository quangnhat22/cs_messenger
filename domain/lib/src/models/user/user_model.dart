part of '../base_model.dart';

enum GenderType {
  male('male'),
  female('female'),
  other('other');

  const GenderType(this.value);

  final String value;

  static GenderType convertStringToGenderType(String? type) {
    if (type == GenderType.male.value) {
      return GenderType.male;
    } else if (type == GenderType.female.value) {
      return GenderType.female;
    } else {
      return GenderType.other;
    }
  }

  static String genderType2Label(GenderType? type) {
    if (GenderType.male == type) {
      return R.strings.male;
    } else if (GenderType.female == type) {
      return R.strings.female;
    } else {
      return R.strings.other;
    }
  }
}

class UserModel extends BaseModel {
  final String id;
  final String? name;
  final String? email;
  final String? avatar;
  final String? phone;
  final GenderType? gender;
  final DateTime? birthday;
  final String? bio;
  final RelationModel? relation;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.avatar,
    this.phone,
    this.gender,
    this.birthday,
    this.bio,
    this.relation,
  });
}
