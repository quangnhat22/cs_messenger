import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

part 'app_avatar_circle_widget.dart';

enum AppAvatarSize {
  small(size: 'small', value: 24),
  medium(size: 'medium', value: 32),
  large(size: 'large', value: 48),
  extraLarge(size: 'extra-large', value: 80),
  extraExtraLarge(size: 'extra-extra-large', value: 160);

  final String size;
  final double value;

  const AppAvatarSize({required this.size, required this.value});
}

abstract class AppAvatarBaseBuilder {
  @protected
  AppAvatarSize? _size;
  @protected
  void Function()? _onPressed;
  @protected
  String? _url;

  AppAvatarBaseBuilder setSize(AppAvatarSize? size);

  AppAvatarBaseBuilder setOnPressed(void Function()? onPressed);

  AppAvatarBaseBuilder setUrl(String? url);

  Widget build(BuildContext context);
}
