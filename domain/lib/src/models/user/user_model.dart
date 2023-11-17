part of '../base_model.dart';

enum GenderType {
  male('male'),
  female('female'),
  other('other');

  const GenderType(this.value);

  final String value;

  static GenderType convertStringToGenderType(String? type) {
    if (GenderType.male.value == type) {
      return GenderType.male;
    } else if (GenderType.female.value == type) {
      return GenderType.female;
    } else {
      return GenderType.other;
    }
  }
}

class UserModel extends BaseModel {
  final String id;
  final String? name;
  final String? avatar;
  final String? phone;
  final GenderType? gender;
  final DateTime? birthday;
  final String? bio;
  final RelationModel? relation;

  UserModel({
    required this.id,
    this.name,
    this.avatar,
    this.phone,
    this.gender,
    this.birthday,
    this.bio,
    this.relation,
  });
}
