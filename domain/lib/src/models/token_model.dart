part of 'base_model.dart';

class TokenModel extends BaseModel {
  final String? accessToken;
  final String? refreshToken;

  TokenModel({this.accessToken, this.refreshToken});
}
