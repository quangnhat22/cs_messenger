part of 'app_text_base_builder.dart';

class AppTextHeadlineMediumWidget extends AppTextBaseBuilder {
  @override
  AppTextHeadlineMediumWidget setColor(Color? color) {
    _color = color;
    return this;
  }

  @override
  AppTextHeadlineMediumWidget setMaxLines(int? maxLines) {
    _maxLines = maxLines;
    return this;
  }

  @override
  AppTextHeadlineMediumWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppTextHeadlineMediumWidget setTextAlign(TextAlign? textAlign) {
    _textAlign = textAlign;
    return this;
  }

  @override
  AppTextHeadlineMediumWidget setTextOverFlow(TextOverflow? textOverflow) {
    _textOverflow = textOverflow;
    return this;
  }

  @override
  AppTextHeadlineMediumWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final orgText = Theme.of(context).textTheme.headlineMedium;

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
