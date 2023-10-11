part of 'app_text_base_builder.dart';

class AppTextTitleLargeWidget extends AppTextBaseBuilder {
  @override
  AppTextTitleLargeWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextTitleLargeWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextTitleLargeWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextTitleLargeWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextTitleLargeWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextTitleLargeWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.titleLarge;

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
