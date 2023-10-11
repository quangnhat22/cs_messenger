part of 'app_text_base_builder.dart';

class AppTextDisplayLargeWidget extends AppTextBaseBuilder {
  @override
  AppTextDisplayLargeWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextDisplayLargeWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextDisplayLargeWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextDisplayLargeWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextDisplayLargeWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextDisplayLargeWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.displayLarge;

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
