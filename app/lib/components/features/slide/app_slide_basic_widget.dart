import 'dart:async';

import 'package:app/components/features/slide/app_dot_indicator_widget.dart';
import 'package:app/components/features/slide/app_slide_button_widget.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppSlideBasicWidget extends StatefulWidget {
  const AppSlideBasicWidget({
    super.key,
    required this.items,
    required this.isShowDots,
    required this.durationNextPage,
    this.padding,
    this.indexInit = 0,
    this.durationAuto,
    this.textSkipButton,
    this.textBackButton,
    this.textNextButton,
    this.onSkip,
    this.onBack,
    this.onNext,
    this.onFinish,
    this.physics,
  });

  final EdgeInsetsGeometry? padding;
  final int indexInit;
  final Duration? durationAuto;
  final Duration durationNextPage;
  final String? textSkipButton;
  final String? textBackButton;
  final String? textNextButton;
  final void Function()? onSkip;
  final void Function()? onBack;
  final void Function()? onNext;
  final void Function()? onFinish;
  final ScrollPhysics? physics;
  final List<Widget> items;
  final bool isShowDots;

  @override
  State<AppSlideBasicWidget> createState() => _AppSlideBasicWidgetState();
}

class _AppSlideBasicWidgetState extends State<AppSlideBasicWidget> {
  late final PageController _pageController;
  int _currentPageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    setState(() {
      _currentPageIndex = widget.indexInit;
    });

    _pageController = PageController(initialPage: widget.indexInit);

    super.initState();

    _timer = widget.durationAuto != null
        ? Timer.periodic(widget.durationAuto!, (Timer timer) {
            int currentPage = _currentPageIndex;

            currentPage =
                (currentPage < widget.items.length - 1) ? ++currentPage : 0;

            _pageController.animateToPage(currentPage,
                duration: widget.durationNextPage, curve: Curves.easeIn);

            setState(() {
              _currentPageIndex = currentPage;
            });
          })
        : null;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: widget.padding ?? EdgeInsets.all(AppSizeExt.of.majorScale(0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.textSkipButton != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButtonTextWidget()
                      .setButtonText(widget.textSkipButton)
                      .setTextStyle(
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ))
                      .setOnPressed(() {
                    //TODO: You didn't use onSkip???
                    widget.onFinish?.call();
                  }).build(context),
                ],
              ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: widget.physics,
                      itemBuilder: (context, index) => widget.items[index],
                      itemCount: widget.items.length,
                      onPageChanged: (pageIndex) {
                        setState(() {
                          _currentPageIndex = pageIndex;
                        });

                        if (pageIndex == widget.items.length - 1 &&
                            widget.durationAuto != null) {
                          widget.onFinish?.call();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppSizeExt.of.majorScale(4),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        widget.items.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              right: AppSizeExt.of.majorPaddingScale(1)),
                          child: AppDotIndicatorWidget(
                            isActive: index == _currentPageIndex,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSizeExt.of.majorScale(4),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                AppSlideButtonWidget(
                  text: widget.textBackButton ?? '-',
                  styleButton: AppSlideButtonStyle.backStyle,
                  isVisible: _currentPageIndex != 0,
                  onTab: () {
                    widget.onBack?.call();
                    _pageController.previousPage(
                        duration: widget.durationNextPage, curve: Curves.ease);
                  },
                ),
                const Spacer(),
                AppSlideButtonWidget(
                  text: widget.textNextButton ?? '-',
                  styleButton: AppSlideButtonStyle.nextStyle,
                  onTab: () {
                    widget.onNext?.call();
                    if (_currentPageIndex == widget.items.length - 1 &&
                        widget.durationAuto == null) {
                      widget.onFinish?.call();
                    }
                    _pageController.nextPage(
                        duration: widget.durationNextPage, curve: Curves.ease);
                  },
                ),
              ],
            ),
            SizedBox(
              height: AppSizeExt.of.majorScale(14),
            )
          ],
        ),
      ),
    );
  }
}
