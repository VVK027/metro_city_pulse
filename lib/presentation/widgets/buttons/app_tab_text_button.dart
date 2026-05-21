import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';

class AppTabTextButton extends StatelessWidget {
  final String title;
  final String value;
  final bool isActive;
  final bool isCompact;
  final VoidCallback? onPressed;

  const AppTabTextButton({
    super.key,
    required this.title,
    required this.value,
    required this.isActive,
    this.isCompact = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final inactiveColor = colorScheme.onSurface;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        foregroundColor: isActive ? Colors.white : inactiveColor,
      ).copyWith(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 6 : 8,
          vertical: isCompact ? 6 : 8,
        ),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [colorScheme.primary, colorScheme.secondary],
                )
              : null,
          color: isActive ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              title,
              color: isActive ? Colors.white : inactiveColor,
              fontWeight: FontWeight.w500,
              size: isCompact ? 12.0 : 14.0,
            ),
            SizedBox(width: isCompact ? 4 : 6),
            AppText(
              value,
              color: isActive ? Colors.white : inactiveColor,
              fontWeight: FontWeight.w600,
              size: isCompact ? 12.0 : 14.0,
            ),
          ],
        ),
      ),
    );
  }
}
