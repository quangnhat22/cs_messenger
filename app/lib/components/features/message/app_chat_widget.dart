import 'dart:math';

import 'package:app/configs/theme/app_theme.dart';
import 'package:diffutil_dart/diffutil.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/bubble_rtl_alignment.dart';

class AppChatWidget extends StatefulWidget {
  const AppChatWidget({
    super.key,
    required this.currentUserId,
    this.bottomWidget,
    required this.bubbleRtlAlignment,
    this.isLastPage,
    this.isFirstPage,
    required this.itemBuilder,
    required this.items,
    this.onEndReached,
    this.onEndReachedThreshold,
    this.onStartReached,
    this.onStartReachedThreshold,
    required this.keyboardDismissBehavior,
    required this.scrollController,
    this.scrollPhysics,
    required this.useTopSafeAreaInset,
    this.bottomContainerWidget,
    this.topContainerWidget,
  });

  final String currentUserId;

  /// A custom widget at the bottom of the list.
  final Widget? bottomWidget;

  /// Used to set alignment of typing indicator.
  /// See [BubbleRtlAlignment].
  final BubbleRtlAlignment bubbleRtlAlignment;

  /// Used for pagination (infinite scroll) together with [onEndReached].
  /// When true, indicates that there are no more pages to load and
  /// pagination will not be triggered.
  final bool? isLastPage;

  // Used for pagination (infinite scroll) together with [onEndReached].
  /// When true, indicates that there are no more pages to load and
  /// pagination will not be triggered.
  final bool? isFirstPage;

  /// Item builder.
  final Widget Function(Object, int? index) itemBuilder;

  /// Items to build.
  final List<Object> items;

  /// Used for pagination (infinite scroll). Called when user scrolls
  /// to the very end of the list (minus [onEndReachedThreshold]).
  final Future<void> Function()? onEndReached;

  /// A representation of how a [ScrollView] should dismiss the on-screen keyboard.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Used for pagination (infinite scroll) together with [onEndReached]. Can be anything from 0 to 1, where 0 is immediate load of the next page as soon as scroll starts, and 1 is load of the next page only if scrolled to the very end of the list. Default value is 0.75, e.g. start loading next page when scrolled through about 3/4 of the available content.
  final double? onEndReachedThreshold;

  /// Scroll controller for the main [CustomScrollView]. Also used to auto scroll
  /// to specific messages.
  final ScrollController scrollController;

  /// Determines the physics of the scroll view.
  final ScrollPhysics? scrollPhysics;

  // final TypingIndicatorOptions? typingIndicatorOptions;

  /// Whether to use top safe area inset for the list.
  final bool useTopSafeAreaInset;

  /// Used for pagination (infinite scroll). Called when user scrolls
  /// to the very end of the list (minus [onStartReachedThreshold]).
  final Future<void> Function()? onStartReached;

  /// Used for pagination (infinite scroll) together with [onStartReached]. Can be anything from 0 to 1, where 0 is immediate load of the next page as soon as scroll starts, and 1 is load of the next page only if scrolled to the very end of the list. Default value is 0.75, e.g. start loading next page when scrolled through about 3/4 of the available content.
  final double? onStartReachedThreshold;

  ///bottom float widget in chat app
  final Widget? bottomContainerWidget;

  ///top float widget in chat app
  final Widget? topContainerWidget;

  @override
  State<AppChatWidget> createState() => _AppChatWidgetState();
}

class _AppChatWidgetState extends State<AppChatWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _animation = CurvedAnimation(
    curve: Curves.easeOutQuad,
    parent: _controller,
  );
  late final AnimationController _controller = AnimationController(vsync: this);

  // bool _indicatorOnScrollStatus = false;

  bool _showButtonGoToBottom = false;

  bool _isNextPageLoading = false;

  bool _isNextBottomPageLoading = false;

  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  late List<Object> _oldData = List.from(widget.items);

  @override
  void initState() {
    super.initState();

    didUpdateWidget(widget);
  }

  @override
  void didUpdateWidget(covariant AppChatWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _calculateDiffs(oldWidget.items);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _calculateDiffs(List<Object> oldList) async {
    final diffResult = calculateListDiff<Object>(
      oldList,
      widget.items,
      equalityChecker: (item1, item2) {
        if (item1 is Map<String, Object> && item2 is Map<String, Object>) {
          final message1 = item1['message']! as IMessageModel;
          final message2 = item2['message']! as IMessageModel;

          return message1.id == message2.id;
        } else {
          return item1 == item2;
        }
      },
    );

    for (final update in diffResult.getUpdates(batch: false)) {
      update.when(
        insert: (pos, count) {
          _listKey.currentState?.insertItem(pos);
        },
        remove: (pos, count) {
          final item = oldList[pos];
          _listKey.currentState?.removeItem(
            pos,
            (_, animation) => _removedMessageBuilder(item, animation),
          );
        },
        change: (pos, payload) {},
        move: (from, to) {},
      );
    }

    _scrollToBottomIfNeeded(oldList);

    _oldData = List.from(widget.items);
  }

  // Hacky solution to reconsider.
  void _scrollToBottomIfNeeded(List<Object> oldList) {
    try {
      // Take index 1 because there is always a spacer on index 0.
      final oldItem = oldList[1];
      final item = widget.items[1];

      if (oldItem is Map<String, Object> && item is Map<String, Object>) {
        final oldMessage = oldItem['message']! as IMessageModel;
        final message = item['message']! as IMessageModel;

        // Compare items to fire only on newly added messages.
        if (oldMessage.id != message.id) {
          // Run only for sent message.
          if (message.author.id == widget.currentUserId) {
            // Delay to give some time for Flutter to calculate new
            // size after new message was added.
            Future.delayed(const Duration(milliseconds: 100), () {
              if (widget.scrollController.hasClients) {
                widget.scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            });
          }
        }
      }
    } catch (e) {
      // Do nothing if there are no items.
    }
  }

  Widget _removedMessageBuilder(Object item, Animation<double> animation) =>
      SizeTransition(
        key: _valueKeyForItem(item),
        axisAlignment: -1,
        sizeFactor: animation.drive(CurveTween(curve: Curves.easeInQuad)),
        child: FadeTransition(
          opacity: animation.drive(CurveTween(curve: Curves.easeInQuad)),
          child: widget.itemBuilder(item, null),
        ),
      );

  Widget _newMessageBuilder(int index, Animation<double> animation) {
    try {
      final item = _oldData[index];

      return SizeTransition(
        key: _valueKeyForItem(item),
        axisAlignment: -1,
        sizeFactor: animation.drive(CurveTween(curve: Curves.easeOutQuad)),
        child: widget.itemBuilder(item, index),
      );
    } catch (e) {
      return const SizedBox();
    }
  }

  Key? _valueKeyForItem(Object item) =>
      _mapMessage(item, (message) => ValueKey(message.id));

  T? _mapMessage<T>(Object maybeMessage, T Function(IMessageModel) f) {
    if (maybeMessage is Map<String, Object>) {
      return f(maybeMessage['message'] as IMessageModel);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) =>
      NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          //handle show button
          if (notification.metrics.pixels >= 50) {
            setState(() {
              _showButtonGoToBottom = true;
            });
          }

          if (notification.metrics.pixels ==
              notification.metrics.minScrollExtent) {
            setState(() {
              _showButtonGoToBottom = false;
            });
          }
          // if (notification.metrics.pixels > 10.0 && !_indicatorOnScrollStatus) {
          //   setState(() {
          //     _indicatorOnScrollStatus = !_indicatorOnScrollStatus;
          //   });
          // } else if (notification.metrics.pixels == 0.0 &&
          //     _indicatorOnScrollStatus) {
          //   setState(() {
          //     _indicatorOnScrollStatus = !_indicatorOnScrollStatus;
          //   });
          // }

          if (widget.onEndReached == null || widget.isLastPage == true) {
            return false;
          }

          if (notification.metrics.pixels >=
              (notification.metrics.maxScrollExtent *
                  (widget.onEndReachedThreshold ?? 0.75))) {
            if (widget.items.isEmpty || _isNextPageLoading) return false;

            _controller.duration = Duration.zero;
            _controller.forward();

            setState(() {
              _isNextPageLoading = true;
            });

            widget.onEndReached!().whenComplete(() {
              if (mounted) {
                _controller.duration = const Duration(milliseconds: 100);

                _controller.reverse();

                setState(() {
                  _isNextPageLoading = false;
                });
              }
            });
          }

          if (notification.metrics.pixels ==
                  notification.metrics.minScrollExtent &&
              widget.onStartReached != null &&
              widget.isFirstPage == false) {
            // _controller.duration = Duration.zero;
            // _controller.forward();

            setState(() {
              _isNextBottomPageLoading = true;
            });

            widget.onStartReached!().whenComplete(() {
              if (mounted) {
                // _controller.duration = const Duration(milliseconds: 1000);
                // _controller.reverse();

                setState(() {
                  _isNextBottomPageLoading = false;
                });
              }
            });
          }

          return false;
        },
        child: Stack(
          children: [
            CupertinoScrollbar(
              controller: widget.scrollController,
              child: CustomScrollView(
                controller: widget.scrollController,
                keyboardDismissBehavior: widget.keyboardDismissBehavior,
                physics: widget.scrollPhysics,
                reverse: true,
                slivers: [
                  if (widget.bottomContainerWidget != null)
                    makeHeader(widget.bottomContainerWidget!),
                  if (widget.bottomWidget != null)
                    SliverToBoxAdapter(child: widget.bottomWidget),

                  // SliverPadding(
                  //   padding: EdgeInsets.only(
                  //     top: 16 +
                  //         (widget.useTopSafeAreaInset
                  //             ? MediaQuery.of(context).padding.bottom
                  //             : 0),
                  //   ),
                  //   sliver: SliverToBoxAdapter(
                  //     child: SizeTransition(
                  //       axisAlignment: 1,
                  //       sizeFactor: _animation,
                  //       child: Center(
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           height: 32,
                  //           width: 32,
                  //           child: SizedBox(
                  //             height: 16,
                  //             width: 16,
                  //             child: _isNextBottomPageLoading
                  //                 ? CircularProgressIndicator(
                  //                     backgroundColor: Colors.transparent,
                  //                     strokeWidth: 1.5,
                  //                     valueColor: AlwaysStoppedAnimation<Color>(
                  //                         Theme.of(context)
                  //                             .colorScheme
                  //                             .primary),
                  //                   )
                  //                 : null,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // SliverPadding(
                  //   padding: const EdgeInsets.only(bottom: 4),
                  //   sliver: SliverToBoxAdapter(
                  //     child: (widget.typingIndicatorOptions!.typingUsers.isNotEmpty &&
                  //             !_indicatorOnScrollStatus)
                  //         ? widget.typingIndicatorOptions?.customTypingIndicator ??
                  //             TypingIndicator(
                  //               bubbleAlignment: widget.bubbleRtlAlignment,
                  //               options: widget.typingIndicatorOptions!,
                  //               showIndicator: (widget.typingIndicatorOptions!
                  //                       .typingUsers.isNotEmpty &&
                  //                   !_indicatorOnScrollStatus),
                  //             )
                  //         : const SizedBox.shrink(),
                  //   ),
                  // ),

                  ///message
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 4),
                    sliver: SliverAnimatedList(
                      findChildIndexCallback: (Key key) {
                        if (key is ValueKey<Object>) {
                          final newIndex = widget.items.indexWhere(
                            (v) => _valueKeyForItem(v) == key,
                          );
                          if (newIndex != -1) {
                            return newIndex;
                          }
                        }
                        return null;
                      },
                      initialItemCount: widget.items.length,
                      key: _listKey,
                      itemBuilder: (_, index, animation) =>
                          _newMessageBuilder(index, animation),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: 16 +
                          (widget.useTopSafeAreaInset
                              ? MediaQuery.of(context).padding.top
                              : 0),
                    ),
                    sliver: SliverToBoxAdapter(
                      child: SizeTransition(
                        axisAlignment: 1,
                        sizeFactor: _animation,
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: 32,
                            width: 32,
                            child: SizedBox(
                              height: 16,
                              width: 16,
                              child: _isNextPageLoading
                                  ? CircularProgressIndicator(
                                      backgroundColor: Colors.transparent,
                                      strokeWidth: 1.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.topContainerWidget != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: widget.topContainerWidget!,
              ),
            if (_showButtonGoToBottom)
              Positioned(
                bottom: AppSizeExt.of.majorScale(5),
                right: AppSizeExt.of.majorScale(5),
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .tertiaryContainer
                      .withOpacity(0.8),
                  onPressed: () async {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      if (widget.scrollController.hasClients) {
                        widget.scrollController.animateTo(
                          0.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      }
                    });
                  },
                  child: const Icon(Icons.arrow_downward_outlined),
                ),
              ),
          ],
        ),
      );

  SliverPersistentHeader makeHeader(Widget bottomFloatWidget) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: _SliverAppBarDelegate(
        minHeight: MediaQuery.sizeOf(context).height / 6,
        maxHeight: MediaQuery.sizeOf(context).height / 5,
        child: Container(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.8),
          child: bottomFloatWidget,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
