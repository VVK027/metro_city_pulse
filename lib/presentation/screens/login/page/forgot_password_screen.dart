import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/presentation/screens/login/provider/auth_provider.dart';
import 'package:metro_city_pulse/presentation/screens/login/provider/login_providers.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_elevated_button.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    final emailError = ref.watch(emailErrorProvider);
    final isLoading = ref.watch(loadingProvider);
    final theme = ref.watch(appThemeStateProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(title: Text("forgot_password".tr(ref).toAllCapitalize())),
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
            const SizedBox(height: 24),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : AppElevatedButton(
                    text: "send_reset_email".tr(ref).toAllCapitalize(),
                    onPressed: () async {
                      if (!isValidEmail(email)) {
                        ref.read(emailErrorProvider.notifier).state =
                            "invalid_email".tr(ref).toAllCapitalize();
                        return;
                      }

                      ref.read(emailErrorProvider.notifier).state = null;
                      ref.read(loadingProvider.notifier).state = true;

                      final result = await sendPasswordReset(ref, email);

                      ref.read(loadingProvider.notifier).state = false;

                      if (result == null) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "reset_email_sent_successfully"
                                  .tr(ref)
                                  .toAllCapitalize(),
                            ),
                          ),
                        );
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      } else {
                        if (!context.mounted) return;
                        showErrorDialog(
                          context,
                          "reset_failed".tr(ref).toAllCapitalize(),
                          result,
                          okLabel: "ok".tr(ref).toUpperCase(),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

Future<String?> sendPasswordReset(WidgetRef ref, String email) async {
  try {
    await ref.read(authProvider).sendPasswordResetEmail(email: email);
    return null;
  } on FirebaseAuthException catch (e) {
    return e.message;
  }
}
