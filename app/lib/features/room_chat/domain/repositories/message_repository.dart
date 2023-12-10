import 'package:domain/domain.dart';

abstract class MessageRepository {
  Future<AppObjResultModel<EmptyModel>> sendMessage(
      {required Map<String, dynamic> message});
}
