import 'package:flutter/material.dart';
import 'package:si_app/src/services/settings/settings_controller.dart';
import 'package:si_app/src/services/settings/settings_service.dart';

import 'src/app.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));
}
