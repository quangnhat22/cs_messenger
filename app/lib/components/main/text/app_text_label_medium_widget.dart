part of 'app_text_base_builder.dart';

class AppTextLabelMediumWidget extends AppTextBaseBuilder {
  @override
  AppTextLabelMediumWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextLabelMediumWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextLabelMediumWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextLabelMediumWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextLabelMediumWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextLabelMediumWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.labelMedium;

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
