part of 'app_avatar_base_builder.dart';

class AppAvatarCircleWidget extends AppAvatarBaseBuilder {
  @override
  Widget build(BuildContext context) {
    if (_size == null) {
      throw Exception("Size is not null");
    }
    if (_url == null || _url == "") {
      return R.pngs.avatarEmpty.image(
        width: _size!.value,
        height: _size!.value,
      );
    } else {
      return ExtendedImage.network(_url!,
          width: _size!.value,
          height: _size!.value,
          fit: BoxFit.cover,
          shape: BoxShape.circle,
          cache: true, loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return null;
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.failed:
            return GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  R.pngs.avatarEmpty.image(),
                  const Positioned(
                    bottom: 0.0,
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Icon(Icons.error_outline),
                  )
                ],
              ),
            );
        }
      });
    }
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
