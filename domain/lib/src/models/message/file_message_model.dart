part of '../base_model.dart';

@freezed
class FileMessageModel extends IMessageModel with _$FileMessageModel {
  // final String? mimeType;
  // final double size;
  // final String uri;
  // final String? name;
  // final bool? isLoading;

  const factory FileMessageModel({
    required String id,
    String? clientId,
    required UserModel author,
    required String content,
    required MessageType type,
    @Default(false) bool isMe,
    StatusMessageType? status,
    required String roomId,
    DateTime? createdAt,
    DateTime? deletedAt,
    @Default(false) bool isLoading,
    String? mimeType,
    required double size,
    required String uri,
    String? name,
  }) = _FileMessageModel;
}
