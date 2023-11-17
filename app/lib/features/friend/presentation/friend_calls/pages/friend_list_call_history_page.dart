import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_calls/widgets/friend_call_list_call_history_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

@RoutePage()
class FriendListCallHistoryPage extends StatelessWidget {
  const FriendListCallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizeExt.of.majorPaddingScale(1),
          ),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizeExt.of.majorPaddingScale(1),
                horizontal: AppSizeExt.of.majorPaddingScale(1),
              ),
              child: const FriendCallListCallHistoryWidget(),
            ),
          ),
        ),
        Positioned(
          bottom: AppSizeExt.of.majorScale(3),
          right: AppSizeExt.of.majorScale(2),
          child: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            spacing: 3,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.accessibility),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                label: 'First',
                onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
              ),
              SpeedDialChild(
                child: const Icon(Icons.brush),
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                label: 'Second',
                onTap: () => debugPrint('SECOND CHILD'),
              ),
              SpeedDialChild(
                child: const Icon(Icons.margin),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                label: 'Show Snackbar',
                visible: true,
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(("Third Child Pressed")))),
                onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
