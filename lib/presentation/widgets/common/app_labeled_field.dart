import 'package:flutter/material.dart';

/// A simple label + child wrapper used by profile/settings style forms.
/// Centralizes the `Text(label) + SizedBox + child` pattern so profile_screen
/// and similar screens don't redefine their own CustomTextField/CustomDropdown.
class AppLabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  final double gap;
  final TextStyle? labelStyle;

  const AppLabeledField({
    super.key,
    required this.label,
    required this.child,
    this.gap = 6,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? const TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: gap),
        child,
      ],
    );
  }
}

/// A labeled, read-only text field used in profile/settings forms.
class AppReadOnlyTextField extends StatelessWidget {
  final String label;
  final String value;

  const AppReadOnlyTextField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)),
    );

    return AppLabeledField(
      label: label,
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          filled: true,
          fillColor: colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: border,
          enabledBorder: border,
        ),
      ),
    );
  }
}

/// A labeled single-option dropdown used in profile/settings forms.
class AppSingleValueDropdown extends StatelessWidget {
  final String label;
  final String value;

  const AppSingleValueDropdown({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppLabeledField(
      label: label,
      child: Container(
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
    );
  }
}
