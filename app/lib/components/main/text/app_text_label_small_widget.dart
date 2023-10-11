part of 'app_text_base_builder.dart';

class AppTextLabelSmallWidget extends AppTextBaseBuilder {
  @override
  AppTextLabelSmallWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextLabelSmallWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextLabelSmallWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextLabelSmallWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextLabelSmallWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextLabelSmallWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.labelSmall;

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
