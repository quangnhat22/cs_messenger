part of '../base_model.dart';

enum SystemContent {
  roomCreated('RoomCreated'),
  memberJoined('MemberJoined'),
  memberLeft('MemberLeft'),
  becomeFriend('BecomeFriend'),
  callStarted('CallStarted'),
  callEnded('CallEnded');

  const SystemContent(this.key);

  final String key;

  static SystemContent convertSystemMessage2Enum(String systemMessage) {
    switch (systemMessage) {
      case 'RoomCreated':
        return SystemContent.roomCreated;
      case 'MemberJoined':
        return SystemContent.memberJoined;
      case 'MemberLeft':
        return SystemContent.memberLeft;
      case 'BecomeFriend':
        return SystemContent.becomeFriend;
      case 'CallStarted':
        return SystemContent.callStarted;
      case 'CallEnded':
        return SystemContent.callEnded;
      default:
        throw Exception('No type found');
    }
  }
}

class SystemMessageModel extends IMessageModel {
  final SystemContent systemMessage;

  SystemMessageModel({
    required super.id,
    super.clientId,
    required super.author,
    required super.content,
    required super.type,
    super.isMe,
    super.status,
    required super.roomId,
    super.createdAt,
    super.deletedAt,
    required this.systemMessage,
  });

  static String convertSystemMessage2String(String systemMessage) {
    switch (systemMessage) {
      case 'RoomCreated':
        return R.strings.roomCreated;
      case 'MemberJoined':
        return R.strings.memberJoined;
      case 'MemberLeft':
        return R.strings.memberLeft;
      case 'BecomeFriend':
        return R.strings.becomeFriend;
      case 'CallStarted':
        return R.strings.callStarted;
      case 'CallEnded':
        return R.strings.callEnded;
      default:
        return R.strings.system;
    }
  }
}
