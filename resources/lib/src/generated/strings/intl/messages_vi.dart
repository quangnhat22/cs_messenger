// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(app) =>
      "Bỏ qua khoảng cách với ${app}. Chia sẻ những kỉ niệm, gửi tin nhắn và video call, bất kể bạn đang ở đâu.";

  static String m1(app) => "Chào mừng đến với ${app}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "back": MessageLookupByLibrary.simpleMessage("Quay lại"),
        "bridgeTheGap": m0,
        "connectingPeopleAnytimeAnywhere": MessageLookupByLibrary.simpleMessage(
            "Kết nối với bạn bè ở mọi lúc, mọi Nơi"),
        "discoverSeamlessMessaging": MessageLookupByLibrary.simpleMessage(
            "Khám phá tính năng nhắn tin mượt mà và cuộc gọi video chất lượng cao. Giữ kết nối với bạn bè và người thân một cách dễ dàng chưa từng có."),
        "experienceThePower": MessageLookupByLibrary.simpleMessage(
            "Trải nghiệm sức mạnh của việc nhắn tin tức thời và cuộc gọi video rõ nét. Kết nối với mọi người trên toàn thế giới dễ dàng."),
        "language": MessageLookupByLibrary.simpleMessage("Vietnamese"),
        "next": MessageLookupByLibrary.simpleMessage("Tiếp tục"),
        "skip": MessageLookupByLibrary.simpleMessage("Bỏ qua"),
        "stayCloseNoMatterDistance":
            MessageLookupByLibrary.simpleMessage("Khoảng cách không là vấn đề"),
        "welcomeToApp": m1
      };
}
