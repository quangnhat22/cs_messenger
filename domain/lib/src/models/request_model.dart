part of 'base_model.dart';

class RequestModel extends BaseModel {
  final String id;
  final UserModel? sender;
  final UserModel? receiver;
  final DateTime? createdAt;

  RequestModel({required this.id, this.sender, this.receiver, this.createdAt});
}
