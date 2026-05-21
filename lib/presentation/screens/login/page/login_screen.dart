import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/presentation/screens/login/provider/login_providers.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/utils/navigation_util.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_elevated_button.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_image_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_rich_text_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_form_field.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/components/hexagon_clipper_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final formKey = GlobalKey<FormState>();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final theme = ref.watch(appThemeStateProvider);
    final screenSize = MediaQuery.sizeOf(context);
    final mobileHexagonHeight = (screenSize.height * 0.32).clamp(180.0, 250.0);

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SafeArea(
        child: !Responsive.isMobile(context)
            ? Row(
                children: [
                  Expanded(flex: 4, child: buildHexagonSection(context, theme)),
                  buildFormSection(context, theme, formKey, ref),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: mobileHexagonHeight,
                    child: buildHexagonSection(context, theme),
                  ),
                  buildFormSection(
                    context,
                    theme,
                    formKey,
                    ref,
                    shouldExpand: true,
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildHexagonSection(BuildContext context, AppTheme theme) {
    return Container(
      color: theme.colors.backgroundColor,
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final shortestSide = constraints.biggest.shortestSide;
          final logoSize = Responsive.isMobile(context)
              ? (shortestSide * 0.5).clamp(120.0, 210.0)
              : (shortestSide * 0.5).clamp(210.0, 550.0);

          return HexagonWidget(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: AppImage(
                theme.assets.policeDepartmentLogo,
                width: double.maxFinite,
                height: Responsive.isMobile(context) ? logoSize : 280,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBottomActionSection(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  NavigationUtil.push(context, '/signup');
                },
                child: AppText('create_account'.tr(ref).toAllCapitalize()),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  NavigationUtil.push(context, '/forgotPassword');
                },
                child: AppText('forgot_password'.tr(ref).toAllCapitalize()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFormSection(
    BuildContext context,
    AppTheme theme,
    GlobalKey<FormState> formKey,
    WidgetRef ref, {
    bool shouldExpand = true,
  }) {
    final formSection = Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 22.0 : 60.0,
      ),
      child: SingleChildScrollView(
        //padding: EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Form(
          key: formKey,
          child: _LoginFormBody(
            onLoginPressed: onLoginPressed,
            bottomActionSection: buildBottomActionSection(context, ref),
          ),
        ),
      ),
    );

    if (!shouldExpand) {
      return formSection;
    }

    return Expanded(flex: 5, child: formSection);
  }

  Future<void> onLoginPressed(WidgetRef ref, BuildContext context) async {
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);

    bool isValid = true;

    if (!isValidEmail(email)) {
      ref.read(emailErrorProvider.notifier).state = 'invalid_email_format'
          .tr(ref)
          .toAllCapitalize();
      isValid = false;
    } else {
      ref.read(emailErrorProvider.notifier).state = null;
    }

    if (password.length < 6) {
      ref.read(passwordErrorProvider.notifier).state = 'password_min_6'
          .tr(ref)
          .toAllCapitalize();
      isValid = false;
    } else {
      ref.read(passwordErrorProvider.notifier).state = null;
    }

    // if (_formKey.currentState!.validate()) {
    //
    // }
    if (isValid) {
      //await loginWithEmailAndPassword(ref, email, password);
      //final loginStatus = ref.read(loginStatusProvider);

      //TODO: Temporary login navigation
      NavigationUtil.pushReplace(context, '/home');

      // if (loginStatus == "success") {
      // if (true) {
      //   if (!context.mounted) return;
      //   ScaffoldMessenger.of(
      //     context,
      //   ).showSnackBar(const SnackBar(content: Text("Login successful")));
      //   NavigationUtil.pushReplace(context, '/home');
      // } else {
      //   // Show error dialog
      //   if (!context.mounted) return;
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: const Text("Login Failed"),
      //       content: Text(loginStatus ?? "Unknown error"),
      //       actions: [
      //         TextButton(
      //           onPressed: () => Navigator.pop(context),
      //           child: const Text("OK"),
      //         ),
      //       ],
      //     ),
      //   );
      // }
    }
  }
}

class _LoginFormBody extends ConsumerWidget {
  final Future<void> Function(WidgetRef ref, BuildContext context)
  onLoginPressed;
  final Widget bottomActionSection;

  const _LoginFormBody({
    required this.onLoginPressed,
    required this.bottomActionSection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeStateProvider);
    final emailError = ref.watch(emailErrorProvider);
    final passwordError = ref.watch(passwordErrorProvider);
    final isPasswordVisible = ref.watch(passwordVisibleProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.center,
          child: AppText(
            'login_with_account'.tr(ref).toAllCapitalize(),
            size: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: AppRichText(
            'by_logging_in_agree'.tr(ref),
            textAlign: TextAlign.center,
            size: 14,
            fontWeight: FontWeight.w400,
            childrenList: [
              {
                'title': 'terms'.tr(ref).toAllCapitalize(),
                'color': theme.colors.primaryColor,
                'clickable': true,
              },
              {'title': ' ${'and'.tr(ref)} ', 'clickable': false},
              {
                'title': 'privacy_policy'.tr(ref).toAllCapitalize(),
                'color': theme.colors.primaryColor,
                'clickable': true,
              },
            ],
            onChildrenPress: (index) {},
          ),
        ),
        const SizedBox(height: 22),
        AppElevatedButton(
          text: 'sso_log_in'.tr(ref).toAllCapitalize(),
          onPressed: () {
            NavigationUtil.pushReplace(context, '/home');
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: AppText('or'.tr(ref).toUpperCase(), size: 12),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),
        AppTextFormField(
          label: 'email_address'.tr(ref).toAllCapitalize(),
          hintText: 'enter_your_email'.tr(ref).toAllCapitalize(),
          errorText: emailError,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => value == null || value.isEmpty
              ? 'email_required'.tr(ref).toAllCapitalize()
              : !value.contains('@')
              ? 'enter_valid_email'.tr(ref).toAllCapitalize()
              : null,
          onChanged: (value) => ref.read(emailProvider.notifier).state = value,
        ),
        const SizedBox(height: 24),
        AppTextFormField(
          label: 'password'.tr(ref).toAllCapitalize(),
          hintText: 'password'.tr(ref).toAllCapitalize(),
          isPassword: true,
          obscureText: !isPasswordVisible,
          errorText: passwordError,
          validator: (value) => value == null || value.length < 6
              ? 'password_min_6'.tr(ref).toAllCapitalize()
              : null,
          onChanged: (value) =>
              ref.read(passwordProvider.notifier).state = value,
          onToggleObscure: () {
            ref.read(passwordVisibleProvider.notifier).state =
                !isPasswordVisible;
          },
        ),
        const SizedBox(height: 24),
        AppElevatedButton(
          text: 'log_in'.tr(ref).toAllCapitalize(),
          onPressed: () async {
            await onLoginPressed(ref, context);
          },
        ),
        const SizedBox(height: 16),
        bottomActionSection,
      ],
    );
  }
}
