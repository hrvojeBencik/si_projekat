import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:si_app/firebase_options.dart';
import 'package:si_app/src/services/settings/settings_controller.dart';
import 'package:si_app/src/services/settings/settings_service.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));
}
