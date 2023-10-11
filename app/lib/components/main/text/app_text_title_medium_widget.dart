part of 'app_text_base_builder.dart';

class AppTextTitleMediumWidget extends AppTextBaseBuilder {
  @override
  AppTextTitleMediumWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextTitleMediumWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextTitleMediumWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextTitleMediumWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextTitleMediumWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextTitleMediumWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.titleMedium;

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
