part of 'app_divider_base_builder.dart';

class AppDividerSpaceLeftWidget extends AppDividerBaseBuilder {
  double? _spaceLeft;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: constraints.maxWidth - _spaceLeft!,
            height: 1,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  AppDividerSpaceLeftWidget setSpaceLeft(double? spaceLeft) {
    _spaceLeft = spaceLeft;
    return this;
  }

  @override
  AppDividerSpaceLeftWidget setWidth(double? width) {
    _width = width;
    return this;
  }
}
