import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? errorText;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onToggleObscure;

  const AppTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.onToggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: isPassword && obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            errorText: errorText,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: onToggleObscure,
                  )
                : null,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
