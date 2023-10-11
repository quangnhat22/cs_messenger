part of 'app_text_base_builder.dart';

class AppTextLabelLargeWidget extends AppTextBaseBuilder {
  @override
  AppTextLabelLargeWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextLabelLargeWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextLabelLargeWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextLabelLargeWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextLabelLargeWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextLabelLargeWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.labelLarge;

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
