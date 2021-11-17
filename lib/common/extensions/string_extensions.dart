import 'package:custom_listview_with_json_data/presentation/app_localizations.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String intelliTrim() {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }

  String translate(BuildContext context) {
    return AppLocalizations.of(context)?.translate(this) ?? '';
  }
}
