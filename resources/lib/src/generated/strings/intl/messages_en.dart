// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(app) =>
      "Bridge the gap with ${app}. Share moments, send messages, and have face-to-face conversations, regardless of where you are.";

  static String m1(app) => "Welcome to ${app}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "bridgeTheGap": m0,
        "connectingPeopleAnytimeAnywhere": MessageLookupByLibrary.simpleMessage(
            "Connecting People, Anytime, Anywhere"),
        "discoverSeamlessMessaging": MessageLookupByLibrary.simpleMessage(
            "Discover seamless messaging and high-quality video calls. Stay connected with friends and loved ones like never before."),
        "experienceThePower": MessageLookupByLibrary.simpleMessage(
            "Experience the power of instant messaging and crystal-clear video calls. Connect with people across the globe with ease."),
        "language": MessageLookupByLibrary.simpleMessage("English"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "stayCloseNoMatterDistance": MessageLookupByLibrary.simpleMessage(
            "Stay Close, No Matter the Distance"),
        "welcomeToApp": m1
      };
}
