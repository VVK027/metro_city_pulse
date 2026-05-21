import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_assets.dart';
import 'package:metro_city_pulse/core/themes/app_colors.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/utils/navigation_util.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_image_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_labeled_field.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_responsive_scope.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeStateProvider);
    final AppColors colors = theme.colors;
    final AppResponsive layout = AppResponsive.fromContext(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 600;
          final double fieldWidth = isWide
              ? constraints.maxWidth / 2 - 30
              : double.infinity;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: TopPortion(colors: colors, assets: theme.assets),
              ),
              const SizedBox(height: 16),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: fieldWidth,
                            child: AppSingleValueDropdown(
                              label: 'department_required'.tr(ref),
                              value:
                                  'police_department'.tr(ref).toAllCapitalize(),
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: AppSingleValueDropdown(
                              label: 'country'.tr(ref).toAllCapitalize(),
                              value: 'india'.tr(ref).toAllCapitalize(),
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: AppSingleValueDropdown(
                              label: 'city'.tr(ref).toAllCapitalize(),
                              value: 'bengaluru'.tr(ref).toAllCapitalize(),
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: AppSingleValueDropdown(
                              label: 'designation'.tr(ref).toAllCapitalize(),
                              value: 'inspector'.tr(ref).toAllCapitalize(),
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: AppReadOnlyTextField(
                              label: 'id_required'.tr(ref).toUpperCase(),
                              value: 'BPD123456',
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: AppReadOnlyTextField(
                              label: 'phone_number_required'
                                  .tr(ref)
                                  .toAllCapitalize(),
                              value: '99XX XXX XXX',
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: AppReadOnlyTextField(
                              label: 'official_email_required'
                                  .tr(ref)
                                  .toAllCapitalize(),
                              value: 'viivek.k@account.com',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _ProfileActionsBar(isMobile: layout.isMobile),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfileActionsBar extends ConsumerWidget {
  final bool isMobile;
  const _ProfileActionsBar({required this.isMobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget save = _ProfilePrimaryButton(
      label: 'save_changes'.tr(ref).toAllCapitalize(),
      onPressed: () {},
    );
    final Widget cancel = _ProfileSecondaryButton(
      label: 'cancel'.tr(ref).toAllCapitalize(),
      onPressed: () => NavigationUtil.pop(context),
    );

    if (isMobile) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          save,
          const SizedBox(height: 16),
          cancel,
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        save,
        const SizedBox(width: 16),
        cancel,
      ],
    );
  }
}

class _ProfilePrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _ProfilePrimaryButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      child: Text(label),
    );
  }
}

class _ProfileSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _ProfileSecondaryButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.primary.withValues(alpha: 0.45)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      child: Text(label),
    );
  }
}

class TopPortion extends StatelessWidget {
  final AppColors colors;
  final AppAssets assets;

  const TopPortion({super.key, required this.colors, required this.assets});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 80),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colors.gradientColor1, colors.gradientColor2],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppText(
                    'Viivek Kumar',
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 8),
                  AppImage(
                    assets.editSquare,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
