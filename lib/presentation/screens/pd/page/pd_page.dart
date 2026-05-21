import 'package:flutter/material.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PDPage extends ConsumerWidget {
  const PDPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text("pd_screen".tr(ref).toAllCapitalize()));
  }
}
