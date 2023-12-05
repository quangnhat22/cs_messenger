part of '../base_model.dart';

@immutable
class DateHeaderModel {
  /// Creates a date header.
  const DateHeaderModel({
    required this.dateTime,
    required this.text,
  });

  /// Message date.
  final DateTime dateTime;

  /// Text to show in a header.
  final String text;
}

@immutable
class MessageSpacer {
  const MessageSpacer({
    required this.height,
    required this.id,
  });

  /// Spacer's height.
  final double height;

  /// Unique ID of the spacer.
  final String id;
}

@immutable
class PreviewImage {
  const PreviewImage({
    required this.id,
    required this.uri,
  });

  final String id;
  final String uri;
}

@immutable
class UnreadHeaderData {
  const UnreadHeaderData({
    this.marginTop,
  });

  final double? marginTop;
}
