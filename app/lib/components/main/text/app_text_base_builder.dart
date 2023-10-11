import 'package:flutter/material.dart';

part 'app_text_body_large_widget.dart';
part 'app_text_body_medium_widget.dart';
part 'app_text_body_small_widget.dart';
part 'app_text_display_large_widget.dart';
part 'app_text_display_medium_widget.dart';
part 'app_text_display_small_widget.dart';
part 'app_text_headline_large_widget.dart';
part 'app_text_headline_medium_widget.dart';
part 'app_text_headline_small_widget.dart';
part 'app_text_label_large_widget.dart';
part 'app_text_label_medium_widget.dart';
part 'app_text_label_small_widget.dart';
part 'app_text_title_large_widget.dart';
part 'app_text_title_medium_widget.dart';
part 'app_text_title_small_widget.dart';

abstract class AppTextBaseBuilder {
  @protected
  String? _text;
  @protected
  TextStyle? _textStyle;
  @protected
  TextAlign? _textAlign;
  @protected
  int? _maxLines;
  @protected
  TextOverflow? _textOverflow;
  @protected
  Color? _color;

  AppTextBaseBuilder setText(String? text);

  AppTextBaseBuilder setTextStyle(TextStyle? textStyle);

  AppTextBaseBuilder setTextAlign(TextAlign? textAlign);

  AppTextBaseBuilder setMaxLines(int? maxLines);

  AppTextBaseBuilder setTextOverFlow(TextOverflow? textOverflow);

  AppTextBaseBuilder setColor(Color? color);

  @protected
  Widget build(BuildContext context) {
    final textStyle = _textStyle?.copyWith(color: _color ?? _textStyle?.color);
    return Text(
      _text ?? '-',
      textAlign: _textAlign,
      style: textStyle,
      maxLines: _maxLines,
      overflow: _textOverflow,
    );
  }
}
