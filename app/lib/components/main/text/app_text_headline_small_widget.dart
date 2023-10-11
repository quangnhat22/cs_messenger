part of 'app_text_base_builder.dart';

class AppTextHeadlineSmallWidget extends AppTextBaseBuilder {
  @override
  AppTextHeadlineSmallWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextHeadlineSmallWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextHeadlineSmallWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextHeadlineSmallWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextHeadlineSmallWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextHeadlineSmallWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.headlineSmall;

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
