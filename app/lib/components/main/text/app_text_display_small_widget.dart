part of 'app_text_base_builder.dart';

class AppTextDisplaySmallWidget extends AppTextBaseBuilder {
  @override
  AppTextDisplaySmallWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextDisplaySmallWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextDisplaySmallWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextDisplaySmallWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextDisplaySmallWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextDisplaySmallWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.displaySmall;

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
