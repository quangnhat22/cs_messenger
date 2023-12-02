import 'package:app/components/features/search/search_delegate.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class SliverSearchAppBarWidget extends StatelessWidget {
  const SliverSearchAppBarWidget({super.key});

  void _handleSearchInputPressed(BuildContext context) {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
    );
  }

  void _handleNotificationIconButtonPressed(BuildContext context) {
    //TODO: implement notification icon button at AppBar
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
      actions: [
        IconButton(
          onPressed: () => _handleNotificationIconButtonPressed(context),
          icon: const Icon(Icons.notifications_outlined),
        )
      ],
      floating: true,
      // forceElevated: innerBoxIsScrolled,
    );
  }

  Widget _buildSearchInput(BuildContext context) {
    return SizedBox(
      height: AppSizeExt.of.majorScale(9),
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
}
