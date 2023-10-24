part of 'app_slide_base_builder.dart';

class AppSlideWidget extends AppSlideBaseBuilder {
  @override
  Widget build(BuildContext context) {
    if (_items == null) {
      throw Exception("items is empty!");
    }
    if (_isShowDots == null) {
      throw Exception("isShowDots is empty!");
    }
    if (_durationNextPage == null) {
      throw Exception("durationNextPage is empty!");
    }

    return AppSlideBasicWidget(
      items: _items!,
      isShowDots: _isShowDots!,
      durationNextPage: _durationNextPage!,
      padding: _padding,
      indexInit: _indexInit ?? 0,
      durationAuto: _durationAuto,
      textSkipButton: _textSkipButton,
      textBackButton: _textBackButton,
      textNextButton: _textNextButton,
      onSkip: _onSkip,
      onBack: _onBack,
      onNext: _onNext,
      onFinish: _onFinish,
      physics: _physics,
    );
  }

  @override
  AppSlideWidget setDurationAuto(Duration durationAuto) {
    _durationAuto = durationAuto;
    return this;
  }

  @override
  AppSlideWidget setDurationNextPage(Duration durationNextPage) {
    _durationNextPage = durationNextPage;
    return this;
  }

  @override
  AppSlideWidget setIndexInit(int indexInit) {
    _indexInit = indexInit;
    return this;
  }

  @override
  AppSlideWidget setIsShowDots(bool isShowDots) {
    _isShowDots = isShowDots;
    return this;
  }

  @override
  AppSlideWidget setItems(List<Widget> items) {
    _items = items;
    return this;
  }

  @override
  AppSlideWidget setOnBack(void Function() onBack) {
    _onBack = onBack;
    return this;
  }

  @override
  AppSlideWidget setOnFinish(void Function() onFinish) {
    _onFinish = onFinish;
    return this;
  }

  @override
  AppSlideWidget setOnNext(void Function() onNext) {
    _onNext = onNext;
    return this;
  }

  @override
  AppSlideWidget setOnSkip(void Function() onSkip) {
    _onSkip = onSkip;
    return this;
  }

  @override
  AppSlideWidget setPadding(EdgeInsetsGeometry padding) {
    _padding = padding;
    return this;
  }

  @override
  AppSlideWidget setScrollPhysics(ScrollPhysics scrollPhysics) {
    _physics = scrollPhysics;
    return this;
  }

  @override
  AppSlideWidget setTextBackButton(String textBackButton) {
    _textBackButton = textBackButton;
    return this;
  }

  @override
  AppSlideWidget setTextNextButton(String textNextButton) {
    _textNextButton = textNextButton;
    return this;
  }

  @override
  AppSlideWidget setTextSkipButton(String textSkipButton) {
    _textSkipButton = textSkipButton;
    return this;
  }
}
