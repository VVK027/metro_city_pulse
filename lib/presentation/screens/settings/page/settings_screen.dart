import 'package:metro_city_pulse/core/provider/language_provider.dart';
import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/core/themes/app_theme_mode.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_elevated_button.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider)!;
    final themeMode = ref.watch(appThemeStateProvider);

    return Scaffold(
      appBar: AppBar(title: AppText("settings".tr(ref).toAllCapitalize())),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: isWide
                ? Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildLocaleCard(ref, locale)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildThemeCard(ref, themeMode)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _saveButton(ref),
                    ],
                  )
                : ListView(
                    shrinkWrap: true,
                    children: [
                      _buildLocaleCard(ref, locale),
                      const SizedBox(height: 16),
                      _buildThemeCard(ref, themeMode),
                      const SizedBox(height: 16),
                      _saveButton(ref),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildLocaleCard(WidgetRef ref, Locale locale) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "language".tr(ref).toAllCapitalize(),
              size: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            RadioGroup<Locale>(
              groupValue: locale,
              onChanged: (Locale? val) {
                ref
                    .read(languageProvider.notifier)
                    .changeLocale(val!.languageCode);
              },
              child: Column(
                children: <Widget>[
                  RadioListTile<Locale>(
                    title: AppText("english".tr(ref)),
                    value: supportedLocales[0],
                  ),
                  RadioListTile<Locale>(
                    title: AppText("spanish".tr(ref)),
                    value: supportedLocales[1],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeCard(WidgetRef ref, AppTheme themeMode) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "theme".tr(ref).toAllCapitalize(),
              size: 18,
              fontWeight: FontWeight.bold,
            ),
            SwitchListTile(
              title: AppText("dark_mode".tr(ref).toAllCapitalize()),
              value: themeMode.mode == AppThemeMode.dark,
              onChanged: (val) {
                ref.read(appThemeStateProvider.notifier).toggle(val);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveButton(WidgetRef ref) {
    return AppElevatedButton(
      onPressed: () async {
        // Persist changes using Riverpod notifiers
        // await ref.read(localeProvider.notifier).setLocale(_tempLocale);
        // await ref.read(themeProvider.notifier).setTheme(_tempTheme);
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(content: AppText("settings_saved".tr(ref).toAllCapitalize())),
        );
      },
      text: "save".tr(ref).toAllCapitalize(),
    );
  }

  // bool get _hasChanges {
  //   final currentLocale = ref.read(localeProvider);
  //   final currentTheme = ref.read(themeProvider);
  //   return _tempLocale != currentLocale || _tempTheme != currentTheme;
  // }
}
