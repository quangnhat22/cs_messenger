import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'skeleton.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Skeleton.circle(
              width: AppSizeExt.of.majorScale(30),
              height: AppSizeExt.of.majorScale(30),
            ),
            SizedBox(
              height: AppSizeExt.of.majorScale(16),
            ),
            Skeleton.rectangular(
              height: AppSizeExt.of.majorScale(3),
              width: AppSizeExt.of.majorScale(90),
            ),
            SizedBox(
              height: AppSizeExt.of.majorScale(4),
            ),
            Skeleton.rectangular(
              height: AppSizeExt.of.majorScale(12),
              width: AppSizeExt.of.majorScale(90),
            ),
            SizedBox(
              height: AppSizeExt.of.majorScale(4),
            ),
            Skeleton.rectangular(
              height: AppSizeExt.of.majorScale(12),
              width: AppSizeExt.of.majorScale(90),
            ),
            SizedBox(
              height: AppSizeExt.of.majorScale(4),
            ),
            Skeleton.rectangular(
              height: AppSizeExt.of.majorScale(12),
              width: AppSizeExt.of.majorScale(90),
            ),
            SizedBox(
              height: AppSizeExt.of.majorScale(4),
            ),
            Skeleton.rectangular(
              height: AppSizeExt.of.majorScale(12),
              width: AppSizeExt.of.majorScale(90),
            ),
            SizedBox(
              height: AppSizeExt.of.majorScale(4),
            ),
            Skeleton.rectangular(
              height: AppSizeExt.of.majorScale(12),
              width: AppSizeExt.of.majorScale(90),
            ),
            SizedBox(
              height: AppSizeExt.of.majorScale(4),
            ),
          ],
        ),
      ),
      // child: ListTile(
      //   leading: Skeleton.circle(
      //     width: 36.w,
      //     height: 36.h,
      //   ),
      //   title: Align(
      //     alignment: Alignment.centerLeft,
      //     child: Skeleton.rectangular(
      //       height: 20.h,
      //       width: 100.w,
      //     ),
      //   ),
      //   subtitle: Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 16.0),
      //     child: Align(
      //       alignment: Alignment.centerLeft,
      //       child: Skeleton.rectangular(
      //         height: 20.h,
      //         width: 200.w,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
