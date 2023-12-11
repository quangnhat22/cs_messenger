import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton.rectangular({
    super.key,
    this.height,
    this.width,
    this.shapeBorder,
  });

  const Skeleton.circle(
      {super.key,
      this.height,
      this.width,
      this.shapeBorder = const CircleBorder()});

  final double? height;
  final double? width;
  final ShapeBorder? shapeBorder;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.outline.withOpacity(0.2),
      highlightColor: Theme.of(context).colorScheme.outline.withOpacity(0.36),
      child: Container(
        height: height ?? AppSizeExt.of.majorScale(6),
        width: width ?? MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.all(AppSizeExt.of.majorScale(2)),
        decoration: ShapeDecoration(
          shape: shapeBorder ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
          color: Theme.of(context).colorScheme.outline.withOpacity(0.6),
        ),
      ),
    );
  }
}
