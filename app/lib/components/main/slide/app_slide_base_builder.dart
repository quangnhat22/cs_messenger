import 'dart:async';

import 'package:app/components/features/slide/app_dot_indicator_widget.dart';
import 'package:app/components/features/slide/app_slide_basic_widget.dart';
import 'package:app/components/features/slide/app_slide_button_widget.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

part 'app_slide_widget.dart';

abstract class AppSlideBaseBuilder {
  @protected
  EdgeInsetsGeometry? _padding;
  @protected
  int? _indexInit;
  @protected
  Duration? _dutationAuto;
  @protected
  Duration? _durationNextPage;
  @protected
  String? _textSkipButton;
  @protected
  void Function()? _onSkip;
  @protected
  String? _textBackButton;
  @protected
  void Function()? _onBack;
  @protected
  String? _textNextButton;
  @protected
  void Function()? _onNext;
  @protected
  void Function()? _onFinish;
  @protected
  List<Widget>? _items;
  @protected
  bool? _isShowDots;
  @protected
  ScrollPhysics? _physics;

  AppSlideBaseBuilder setPadding(EdgeInsetsGeometry padding);

  AppSlideBaseBuilder setIndexInit(int indexInit);

  AppSlideBaseBuilder setDurationAuto(Duration durationAuto);

  AppSlideBaseBuilder setDurationNextPage(Duration durationNextPage);

  AppSlideBaseBuilder setTextSkipButton(String textSkipButton);

  AppSlideBaseBuilder setTextBackButton(String textBackButton);

  AppSlideBaseBuilder setTextNextButton(String textNextButton);

  AppSlideBaseBuilder setOnSkip(void Function() onSkip);

  AppSlideBaseBuilder setOnBack(void Function() onBack);

  AppSlideBaseBuilder setOnNext(void Function() onNext);

  AppSlideBaseBuilder setOnFinish(void Function() onFinish);

  AppSlideBaseBuilder setItems(List<Widget> items);

  AppSlideBaseBuilder setIsShowDots(bool isShowDots);

  AppSlideBaseBuilder setScrollPhysics(ScrollPhysics scrollPhysics);

  Widget build(BuildContext context);
}
