import 'package:metro_city_pulse/core/provider/language_provider.dart';
import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/core/themes/app_theme_mode.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarActionButtons extends ConsumerWidget {
  final AppTheme theme;

  const AppBarActionButtons({super.key, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = Responsive.isMobile(context);
    final isDark = theme.mode == AppThemeMode.dark;
    final locale = ref.watch(languageProvider);
    final langCode = (locale?.languageCode ?? 'en').toUpperCase();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LanguageSelectorButton(
          theme: theme,
          langCode: langCode,
          isMobile: isMobile,
          onLanguageChanged: (code) {
            ref.read(languageProvider.notifier).changeLocale(code);
          },
        ),
        const SizedBox(width: 6),
        _ActionIconButton(
          theme: theme,
          icon: Icons.notifications_none_rounded,
          tooltip: 'Notifications',
          onPressed: () {
            _showNotificationsSnackBar(context);
          },
        ),
        const SizedBox(width: 6),
        _ActionIconButton(
          theme: theme,
          icon: isDark
              ? Icons.light_mode_rounded
              : Icons.dark_mode_rounded,
          tooltip: isDark ? 'Light Mode' : 'Dark Mode',
          onPressed: () {
            ref.read(appThemeStateProvider.notifier).toggle(!isDark);
          },
        ),
      ],
    );
  }

  void _showNotificationsSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No new notifications'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class _LanguageSelectorButton extends StatelessWidget {
  final AppTheme theme;
  final String langCode;
  final bool isMobile;
  final ValueChanged<String> onLanguageChanged;

  const _LanguageSelectorButton({
    required this.theme,
    required this.langCode,
    required this.isMobile,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      elevation: 2,
      color: theme.colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tooltip: 'Change Language',
      onSelected: onLanguageChanged,
      itemBuilder: (context) => [
        _buildLanguageItem('en', 'English'),
        _buildLanguageItem('es', 'Español'),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.colors.lightGray.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language_rounded,
              size: 18,
              color: theme.colors.text,
            ),
            const SizedBox(width: 4),
            Text(
              langCode,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.colors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildLanguageItem(String code, String label) {
    final isSelected = langCode == code.toUpperCase();
    return PopupMenuItem<String>(
      value: code,
      height: 40,
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            size: 18,
            color: isSelected ? theme.colors.primaryColor : theme.colors.gray,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: theme.colors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  final AppTheme theme;
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _ActionIconButton({
    required this.theme,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colors.background,
            shape: BoxShape.circle,
            border: Border.all(color: theme.colors.lightGray.withValues(alpha: 0.4)),
          ),
          child: Icon(
            icon,
            size: 18,
            color: theme.colors.text,
          ),
        ),
      ),
    );
  }
}
