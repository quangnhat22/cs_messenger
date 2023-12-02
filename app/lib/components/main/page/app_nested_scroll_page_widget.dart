part of 'app_main_page_base_builder.dart';

class AppNestedScrollPageWidget extends AppMainPageBaseBuilder {
  ScrollController? _scrollController;

  Widget? _sliverAppBar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          key: _key,
          backgroundColor:
              _backgroundColor ?? Theme.of(context).colorScheme.background,
          appBar: _appBar,
          endDrawer: _endDrawer,
          endDrawerEnableOpenDragGesture: false,
          onEndDrawerChanged: _onEndDrawerChanged,
          resizeToAvoidBottomInset: _resizeToAvoidBottomInset ?? false,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [_sliverAppBar ?? const SizedBox()];
            },
            body: _body ?? const SizedBox(),
          ),
          floatingActionButton: _floatActionButton,
        ),
      ),
    );
  }

  AppNestedScrollPageWidget setSliverAppBar(Widget? sliverAppBar) {
    _sliverAppBar = sliverAppBar;
    return this;
  }

  @override
  AppNestedScrollPageWidget setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  @override
  AppNestedScrollPageWidget setBody(Widget? body) {
    _body = body;
    return this;
  }

  @override
  AppNestedScrollPageWidget setEndDrawer(Widget? endDrawer) {
    _endDrawer = endDrawer;
    return this;
  }

  @override
  AppNestedScrollPageWidget setEndDrawerChanged(
      void Function(bool p1)? onEndDrawerChanged) {
    _onEndDrawerChanged = onEndDrawerChanged;
    return this;
  }

  AppNestedScrollPageWidget setScrollController(
      ScrollController scrollController) {
    _scrollController = scrollController;
    return this;
  }

  @override
  AppNestedScrollPageWidget setKey(Key? key) {
    _key = key;
    return this;
  }

  @override
  AppNestedScrollPageWidget setAppBar(PreferredSizeWidget? appBar) {
    _appBar = appBar;
    return this;
  }

  @override
  AppNestedScrollPageWidget setResizeToAvoidBottomInset(
      bool? resizeToAvoidBottomInset) {
    _resizeToAvoidBottomInset = resizeToAvoidBottomInset;
    return this;
  }

  @override
  AppNestedScrollPageWidget setFloatActionButton(Widget? floatActionButton) {
    _floatActionButton = floatActionButton;
    return this;
  }
}
