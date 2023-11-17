part of '../base_model.dart';

class EmailVerifyModel extends BaseModel {
  final TokenModel? token;
  final DateTime? expireTime;
  final String? email;

  EmailVerifyModel({this.token, this.email, this.expireTime});
}
