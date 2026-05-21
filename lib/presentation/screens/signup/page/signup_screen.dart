import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/presentation/screens/login/provider/auth_provider.dart';
import 'package:metro_city_pulse/presentation/screens/login/provider/login_providers.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/utils/navigation_util.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_elevated_button.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);
    final emailError = ref.watch(emailErrorProvider);
    final passwordError = ref.watch(passwordErrorProvider);
    final isLoading = ref.watch(loadingProvider);
    final theme = ref.watch(appThemeStateProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(title: Text("create_account".tr(ref).toAllCapitalize())),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextFormField(
              label: "email".tr(ref).toAllCapitalize(),
              hintText: "enter_your_email".tr(ref).toAllCapitalize(),
              keyboardType: TextInputType.emailAddress,
              errorText: emailError,
              validator: (value) => value == null || value.isEmpty
                  ? "email_required".tr(ref).toAllCapitalize()
                  : !value.contains('@')
                  ? "enter_valid_email".tr(ref).toAllCapitalize()
                  : null,
              onChanged: (value) =>
                  ref.read(emailProvider.notifier).state = value,
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              label: "password".tr(ref).toAllCapitalize(),
              hintText: "enter_password".tr(ref).toAllCapitalize(),
              isPassword: true,
              obscureText: !ref.watch(signupPasswordVisibleProvider),
              errorText: passwordError,
              validator: (value) => value == null || value.length < 6
                  ? "min_6_characters".tr(ref).toAllCapitalize()
                  : null,
              onChanged: (value) =>
                  ref.read(passwordProvider.notifier).state = value,
              onToggleObscure: () {
                ref.read(signupPasswordVisibleProvider.notifier).state = !ref
                    .read(signupPasswordVisibleProvider);
              },
            ),

            const SizedBox(height: 24),
            isLoading
                ? const CircularProgressIndicator()
                : Center(
                    child: SizedBox(
                      child: AppElevatedButton(
                        text: "sign_up".tr(ref).toAllCapitalize(),
                        isFullWidth: true,
                        onPressed: () async {
                          final valid = validateInputs(ref);
                          if (!valid) return;

                          ref.read(loadingProvider.notifier).state = true;

                          final result = await createAccount(
                            ref,
                            email,
                            password,
                          );

                          ref.read(loadingProvider.notifier).state = false;

                          if (result == null) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "account_created".tr(ref).toAllCapitalize(),
                                ),
                              ),
                            );
                            NavigationUtil.pushReplace(context, '/home');
                          } else {
                            if (!context.mounted) return;
                            showErrorDialog(
                              context,
                              "sign_up_failed".tr(ref).toAllCapitalize(),
                              result,
                              okLabel: "ok".tr(ref).toUpperCase(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

Future<String?> createAccount(
  WidgetRef ref,
  String email,
  String password,
) async {
  try {
    await ref
        .read(authProvider)
        .createUserWithEmailAndPassword(email: email, password: password);
    return null; // success
  } on FirebaseAuthException catch (e) {
    return e.message;
  }
}
