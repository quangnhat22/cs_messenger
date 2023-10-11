part of 'app_text_base_builder.dart';

class AppTextBodyLargeWidget extends AppTextBaseBuilder {
  @override
  AppTextBodyLargeWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextBodyLargeWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextBodyLargeWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextBodyLargeWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextBodyLargeWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextBodyLargeWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.bodyLarge;

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
