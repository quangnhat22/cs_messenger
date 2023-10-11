part of 'app_text_base_builder.dart';

class AppTextBodySmallWidget extends AppTextBaseBuilder {
  @override
  AppTextBodySmallWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextBodySmallWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextBodySmallWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextBodySmallWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextBodySmallWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextBodySmallWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.bodySmall;

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
