import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_assets.dart';
import 'package:metro_city_pulse/core/themes/app_colors.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/utils/navigation_util.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_image_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeStateProvider);
    final colors = theme.colors;
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          final fieldWidth = isWide
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
                            child: CustomDropdown(
                              label: "department_required".tr(ref),
                              value: "police_department"
                                  .tr(ref)
                                  .toAllCapitalize(),
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: CustomDropdown(
                              label: "country".tr(ref).toAllCapitalize(),
                              value: "india".tr(ref).toAllCapitalize(),
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: CustomDropdown(
                              label: "city".tr(ref).toAllCapitalize(),
                              value: "bengaluru".tr(ref).toAllCapitalize(),
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: CustomDropdown(
                              label: "designation".tr(ref).toAllCapitalize(),
                              value: "inspector".tr(ref).toAllCapitalize(),
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: CustomTextField(
                              label: "id_required".tr(ref).toUpperCase(),
                              value: "BPD123456",
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: CustomTextField(
                              label: "phone_number_required"
                                  .tr(ref)
                                  .toAllCapitalize(),
                              value: "99XX XXX XXX",
                            ),
                          ),
                          SizedBox(
                            width: fieldWidth,
                            child: CustomTextField(
                              label: "official_email_required"
                                  .tr(ref)
                                  .toAllCapitalize(),
                              value: "viivek.k@account.com",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        child: isMobile
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildSaveButton(context, ref),
                                  const SizedBox(height: 16),
                                  _buildCancelButton(context, ref),
                                ],
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildSaveButton(context, ref),
                                  const SizedBox(width: 16),
                                  _buildCancelButton(context, ref),
                                ],
                              ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // CircleAvatar(
              //   radius: 80,
              //   backgroundColor: Colors.white,
              //   child: Icon(
              //     Icons.person,
              //     size: 80,
              //     color: Colors.grey[400],
              //   ),
              // child: _image == null
              //     ? Icon(
              //   Icons.person,
              //   size: 80,
              //   color: Colors.grey[400],
              // )
              //     : ClipOval(
              //   child: Image.file(
              //     File(_image!.path),
              //     fit: BoxFit.cover,
              //     width: 160,
              //     height: 160,
              //   ),
              // ),
              //),
              // const CircleAvatar(
              //   radius: 60,
              //   backgroundImage: AssetImage('assets/images/total-videos-icon.svg'), // Replace with your image asset
              // ),
            ],
          );
        },
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String label;
  final String value;

  const CustomDropdown({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(8),
            color: colorScheme.surface,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              icon: Icon(Icons.keyboard_arrow_down, color: colorScheme.onSurface),
              dropdownColor: colorScheme.surface,
              items: [DropdownMenuItem(value: value, child: Text(value))],
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String value;

  const CustomTextField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildSaveButton(BuildContext context, WidgetRef ref) {
  final colorScheme = Theme.of(context).colorScheme;
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
    child: Text('save_changes'.tr(ref).toAllCapitalize()),
  );
}

Widget _buildCancelButton(BuildContext context, WidgetRef ref) {
  final colorScheme = Theme.of(context).colorScheme;
  return OutlinedButton(
    onPressed: () {
      NavigationUtil.pop(context);
    },
    style: OutlinedButton.styleFrom(
      backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
      foregroundColor: colorScheme.primary,
      side: BorderSide(color: colorScheme.primary.withValues(alpha: 0.45)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
    child: Text('cancel'.tr(ref).toAllCapitalize()),
  );
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
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
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
                      backgroundColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey[500],
                      ),
                    ),
                    // TODO: need to use AppImage instead of CircleAvatar
                    // Container(
                    //   decoration: const BoxDecoration(
                    //     color: Colors.black,
                    //     shape: BoxShape.circle,
                    //     image: DecorationImage(
                    //       fit: BoxFit.cover,
                    //       image: NetworkImage(
                    //         'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: CircleAvatar(
                    //     radius: 20,
                    //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    //     child: Container(
                    //       margin: const EdgeInsets.all(8.0),
                    //       decoration: const BoxDecoration(
                    //         color: Colors.green,
                    //         shape: BoxShape.circle,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppText(
                    "Viivek Kumar",
                    size: 20,
                    fontWeight: FontWeight.bold,
                    //style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
