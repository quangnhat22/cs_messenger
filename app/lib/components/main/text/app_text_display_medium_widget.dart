part of 'app_text_base_builder.dart';

class AppTextDisplayMediumWidget extends AppTextBaseBuilder {
  @override
  AppTextDisplayMediumWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextDisplayMediumWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextDisplayMediumWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextDisplayMediumWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextDisplayMediumWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextDisplayMediumWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.displayMedium;

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
