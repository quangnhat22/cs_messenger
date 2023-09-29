import 'package:flutter/cupertino.dart';

enum AppButtonSize {
  large(size: 'large'),

  final String size;

  const AppButtonSize {

}
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

}