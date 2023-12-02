part of 'app_avatar_base_builder.dart';

class AppAvatarCircleWidget extends AppAvatarBaseBuilder {
  @override
  Widget build(BuildContext context) {
    if (_size == null) {
      throw Exception("Size is not null");
    }
    return ExtendedImage.network(
      _url ?? '-',
      width: _size!.value,
      height: _size!.value,
      fit: BoxFit.cover,
      shape: BoxShape.circle,
      cache: true,
    );
  }

  @override
  AppAvatarCircleWidget setOnPressed(void Function()? onPressed) {
    _onPressed = onPressed;
    return this;
  }

  @override
  AppAvatarCircleWidget setSize(AppAvatarSize? size) {
    _size = size;
    return this;
  }

  @override
  AppAvatarCircleWidget setUrl(String? url) {
    _url = url;
    return this;
  }
}
