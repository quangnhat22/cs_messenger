part of 'app_text_base_builder.dart';

class AppTextTitleSmallWidget extends AppTextBaseBuilder {
  @override
  AppTextTitleSmallWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextTitleSmallWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextTitleSmallWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextTitleSmallWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextTitleSmallWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextTitleSmallWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.titleSmall;

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
