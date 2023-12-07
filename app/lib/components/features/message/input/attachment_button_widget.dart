import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class AttachmentButton extends StatelessWidget {
  const AttachmentButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  final bool isLoading;
  final VoidCallback? onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsetsDirectional.fromSTEB(
            AppSizeExt.of.majorScale(2), 0, 0, 0),
        child: IconButton(
          constraints: BoxConstraints(
            minHeight: AppSizeExt.of.majorScale(7),
            minWidth: AppSizeExt.of.majorScale(7),
          ),
          icon: isLoading
              ? SizedBox(
                  height: AppSizeExt.of.majorScale(5),
                  width: AppSizeExt.of.majorScale(5),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                )
              : R.pngs.iconAttachment.image(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          onPressed: isLoading ? null : onPressed,
          padding: padding,
          splashRadius: AppSizeExt.of.majorScale(7),
          tooltip: 'Send media',
        ),
      );
}
