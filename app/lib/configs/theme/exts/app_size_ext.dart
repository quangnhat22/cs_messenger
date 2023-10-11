part of '../app_theme.dart';

class AppSizeExt {
  @protected
  final double _sizeBase = 4.0;
  final double _sizePaddingBase = 4.0;
  final double _sizeMarginBase = 4.0;

  AppSizeExt._();

  static AppSizeExt get of => AppSizeExt._();

  double Function(num x) get majorScale => (x) => _sizeBase * x;

  // For Padding
  double Function(num x) get majorPaddingScale => (x) => _sizePaddingBase * x;

  // For Margin
  double Function(num x) get majorMarginScale => (x) => _sizeMarginBase * x;
}
