import 'package:app/components/features/skeleton/skeleton.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
          child: ListTile(
            leading: Skeleton.circle(
              width: AppSizeExt.of.majorScale(10),
              height: AppSizeExt.of.majorScale(10),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Skeleton.rectangular(
                height: AppSizeExt.of.majorScale(12),
              ),
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }
}
