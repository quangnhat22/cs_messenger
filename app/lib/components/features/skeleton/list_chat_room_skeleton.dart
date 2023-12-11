import 'package:app/components/features/skeleton/skeleton.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ChatRoomsSkeleton extends StatelessWidget {
  const ChatRoomsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                height: AppSizeExt.of.majorScale(10),
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizeExt.of.majorPaddingScale(4)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Skeleton.rectangular(
                  height: AppSizeExt.of.majorScale(5),
                  width: AppSizeExt.of.majorScale(50),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }
}
