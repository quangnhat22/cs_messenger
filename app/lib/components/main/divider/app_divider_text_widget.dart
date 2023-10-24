part of 'app_divider_base_builder.dart';

class AppDividerTextWidget extends AppDividerBaseBuilder {
  String? _text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Divider(
                color: Theme.of(context).colorScheme.scrim,
                height: 36,
              ),
            ),
          ),
          Text(_text!),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Divider(
                color: Theme.of(context).colorScheme.scrim,
                height: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppDividerTextWidget setText(String? text) {
    _text = text;
    return this;
  }

  @override
  AppDividerTextWidget setWidth(double? width) {
    _width = width;
    return this;
  }
}
