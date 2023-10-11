import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

part 'app_button_filled_widget.dart';
part 'app_button_outline_widget.dart';
part 'app_button_text_widget.dart';

enum AppButtonSize {
  large(size: 'large'),
  medium(size: 'medium'),
  small(size: 'small');

  final String size;

  const AppButtonSize({required this.size});
}

enum AppButtonType {
  standard(type: 'standard'),
  danger(type: 'danger'),
  circle(type: 'circle'),
  square(type: 'square');

  final String type;

  const AppButtonType({required this.type});
}

abstract class AppButtonBaseBuilder {
  @protected
  String? _buttonText;
  @protected
  bool? _isDisable;
  @protected
  Widget? _prefixIcon;
  @protected
  Widget? _suffixIcon;
  @protected
  TextStyle? _textStyle;
  @protected
  AppButtonSize? _appButtonSize;
  @protected
  AppButtonType? _appButtonType;
  @protected
  void Function()? _onPressed;

  AppButtonBaseBuilder setButtonText(String? buttonText);

  AppButtonBaseBuilder setIsDisable(bool? isDisable);

  AppButtonBaseBuilder setSuffixIcon(Widget? suffixIcon);

  AppButtonBaseBuilder setPrefixIcon(Widget? prefixIcon);

  AppButtonBaseBuilder setAppButtonSize(AppButtonSize? appButtonSize);

  AppButtonBaseBuilder setAppButtonType(AppButtonType? appButtonType);

  AppButtonBaseBuilder setOnPressed(void Function()? onPressed);

  AppButtonBaseBuilder setTextStyle(TextStyle? textStyle);

  Widget build(BuildContext context);
}
