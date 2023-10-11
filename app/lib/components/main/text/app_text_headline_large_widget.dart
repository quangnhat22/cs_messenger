part of 'app_text_base_builder.dart';

class AppTextHeadlineLargeWidget extends AppTextBaseBuilder {
  @override
  AppTextHeadlineLargeWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextHeadlineLargeWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextHeadlineLargeWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextHeadlineLargeWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextHeadlineLargeWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextHeadlineLargeWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.headlineLarge;

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
