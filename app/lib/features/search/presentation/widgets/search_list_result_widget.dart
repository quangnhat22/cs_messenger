import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchListResultWidget extends StatefulWidget {
  const SearchListResultWidget({
    super.key,
    required this.title,
    required this.itemBuilder,
    this.itemCount = 0,
  });

  final String title;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;

  @override
  State<SearchListResultWidget> createState() => _SearchListResultWidgetState();
}

class _SearchListResultWidgetState extends State<SearchListResultWidget> {
  bool expandFlag = true;

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
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizeExt.of.majorPaddingScale(2),
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
                    ))
              ],
            ),
          ),
          ExpandableContainer(
            expanded: expandFlag,
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
