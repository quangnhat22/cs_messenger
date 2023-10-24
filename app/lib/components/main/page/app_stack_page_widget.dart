part of 'app_main_page_base_builder.dart';

class AppStackPageWidget extends AppMainPageBaseBuilder {
  bool? _isShowCircleBackgroundWidget;
  Color? _backgroundColorCircle;
  Widget? _backWidget;
  Widget? _topWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          key: _key,
          backgroundColor:
              _backgroundColor ?? Theme.of(context).colorScheme.surfaceVariant,
          appBar: _appBar,
          endDrawer: _endDrawer,
          endDrawerEnableOpenDragGesture: false,
          onEndDrawerChanged: _onEndDrawerChanged,
          resizeToAvoidBottomInset: _resizeToAvoidBottomInset ?? false,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              if (_isShowCircleBackgroundWidget == true)
                _backgroundCircleWidget(context),
              _backWidget ?? const SizedBox(),
              _topWidget ?? const SizedBox(),
              _body ?? const SizedBox(),
            ],
          ),
          floatingActionButton: _floatActionButton,
        ),
      ),
    );
  }

  Widget _backgroundCircleWidget(BuildContext context) {
    return Positioned(
      top: -AppSizeExt.of.majorScale(100),
      left: 0,
      right: 0,
      child: Container(
        height: AppSizeExt.of.majorScale(200),
        decoration: BoxDecoration(
          color: _backgroundColorCircle,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(
              AppSizeExt.of.majorScale(250 / 4),
              AppSizeExt.of.majorScale(30),
            ),
          ),
        ),
      ),
    );
  }

  AppStackPageWidget setBackgroundColorCircle(Color? backgroundColorCircle) {
    _backgroundColorCircle = backgroundColorCircle;
    return this;
  }

  AppStackPageWidget setShowCircleBackgroundWidget(
      bool? isShowCircleBackgroundWidget) {
    _isShowCircleBackgroundWidget = isShowCircleBackgroundWidget;
    return this;
  }

  AppStackPageWidget setBackWidget(Widget? backWidget) {
    _backWidget = backWidget;
    return this;
  }

  AppStackPageWidget setTopWidget(Widget? topWidget) {
    _topWidget = topWidget;
    return this;
  }

  @override
  AppStackPageWidget setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  @override
  AppStackPageWidget setBody(Widget? body) {
    _body = body;
    return this;
  }

  @override
  AppStackPageWidget setEndDrawer(Widget? endDrawer) {
    _endDrawer = endDrawer;
    return this;
  }

  @override
  AppStackPageWidget setEndDrawerChanged(
      void Function(bool p1)? onEndDrawerChanged) {
    _onEndDrawerChanged = onEndDrawerChanged;
    return this;
  }

  @override
  AppStackPageWidget setKey(Key? key) {
    _key = key;
    return this;
  }

  @override
  AppStackPageWidget setAppBar(PreferredSizeWidget? appBar) {
    _appBar = appBar;
    return this;
  }

  @override
  AppStackPageWidget setResizeToAvoidBottomInset(
      bool? resizeToAvoidBottomInset) {
    _resizeToAvoidBottomInset = resizeToAvoidBottomInset;
    return this;
  }

  @override
  AppStackPageWidget setFloatActionButton(Widget? floatActionButton) {
    _floatActionButton = floatActionButton;
    return this;
  }
}
