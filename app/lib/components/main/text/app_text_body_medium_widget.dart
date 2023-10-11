part of 'app_text_base_builder.dart';

class AppTextBodyMediumWidget extends AppTextBaseBuilder {
  @override
  AppTextBodyMediumWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextBodyMediumWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextBodyMediumWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextBodyMediumWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextBodyMediumWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextBodyMediumWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.bodyMedium;

    if (_textStyle == null) {
      setTextStyle(orgText);
    } else {
      setTextStyle(_textStyle?.copyWith(
        fontSize: orgText?.fontSize,
        height: orgText?.height,
        letterSpacing: orgText?.letterSpacing,
      ));
    }

    return super.build(context);
  }
}
