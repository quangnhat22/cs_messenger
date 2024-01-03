import 'package:app/components/features/slide/app_dot_indicator_widget.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchListResultWidget extends StatefulWidget {
  const SearchListResultWidget({
    super.key,
    required this.title,
    required this.itemBuilder,
    this.itemCount = 0,
    required this.totalResult,
  });

  final String title;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final int totalResult;

  @override
  State<SearchListResultWidget> createState() => _SearchListResultWidgetState();
}

class _SearchListResultWidgetState extends State<SearchListResultWidget> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizeExt.of.majorPaddingScale(1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizeExt.of.majorPaddingScale(3),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: AppSizeExt.of.majorPaddingScale(1),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppSizeExt.of.majorScale(4),
              ),
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AppTextTitleMediumWidget()
                    .setText(widget.title)
                    .setTextStyle(TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ))
                    .build(context),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppDotIndicatorWidget(
                      isActive: widget.itemCount != 0,
                      height: AppSizeExt.of.majorScale(5),
                      width: AppSizeExt.of.majorScale(5),
                      activeColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      child: AppTextBodySmallWidget()
                          .setText(widget.itemCount.toString())
                          .setTextStyle(
                            TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          )
                          .build(context),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            expandFlag = !expandFlag;
                          },
                        );
                      },
                      icon: Icon(
                        expandFlag
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ExpandableContainer(
            expanded: expandFlag,
            expandedHeight: widget.totalResult != 0
                ? MediaQuery.sizeOf(context).height / widget.totalResult
                : MediaQuery.sizeOf(context).height,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: widget.itemBuilder,
              itemCount: widget.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  const ExpandableContainer({
    super.key,
    required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 300.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: Container(
        child: child,
      ),
    );
  }
}
