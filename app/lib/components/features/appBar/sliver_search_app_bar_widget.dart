import 'package:app/components/features/search/search_delegate.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/app/presentation/controllers/app_notification/app_notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class SliverSearchAppBarWidget extends StatelessWidget {
  const SliverSearchAppBarWidget({super.key});

  void _handleSearchInputPressed(BuildContext context) {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
    );
  }

  void _handleNotificationIconButtonPressed(BuildContext context) async {
    context.read<AppNotificationCubit>().removeNewNotificationStatus();
    await getIt<AppRouter>().push(const ListNotificationRoute());
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      backgroundColor: Colors.transparent,
      title: _buildSearchInput(context),
      actions: [_buildNotificationWidget(context)],
      floating: true,
      // forceElevated: innerBoxIsScrolled,
    );
  }

  Widget _buildSearchInput(BuildContext context) {
    return SizedBox(
      height: AppSizeExt.of.majorScale(10),
      child: InkWell(
        onTap: () => _handleSearchInputPressed(context),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizeExt.of.majorScale(8)),
        ),
        child: TextFormField(
          enabled: false,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isCollapsed: true,
            hintText: R.strings.search,
            alignLabelWithHint: true,
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor:
                Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppSizeExt.of.majorScale(8)),
              ),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
          onFieldSubmitted: (value) {},
        ),
      ),
    );
  }

  Widget _buildNotificationWidget(BuildContext context) {
    return BlocBuilder<AppNotificationCubit, AppNotificationState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(right: AppSizeExt.of.majorScale(2)),
          child: Stack(
            children: [
              IconButton(
                onPressed: () => _handleNotificationIconButtonPressed(context),
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 32,
                ),
              ),
              if (state.isHasNewNotification)
                Positioned(
                  top: AppSizeExt.of.majorScale(3),
                  right: AppSizeExt.of.majorScale(3),
                  child: Container(
                    width: AppSizeExt.of.majorScale(3),
                    height: AppSizeExt.of.majorScale(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColorPalette.of.redColor[5],
                      border: Border.all(
                        color: AppColorPalette.of.grayColor[1]!,
                        width: AppSizeExt.of.majorScale(1 / 4),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
