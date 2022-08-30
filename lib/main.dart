import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ytstream_dlg/src/app.dart';
import 'package:ytstream_dlg/src/constants.dart';
import 'package:ytstream_dlg/src/features/theme/controllers/theme_controller.dart';
import 'package:ytstream_dlg/src/features/theme/services/theme_service.dart';
import 'package:ytstream_dlg/src/features/theme/services/theme_service_hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ThemeService themeService =
      ThemeServiceHive('ytstream_dlg_color_scheme_settings');
  await themeService.init();
  final ThemeController themeController = ThemeController(themeService);
  // Load all the preferred theme settings, while the app is loading, before
  // MaterialApp is created. This prevents a sudden theme change when the app
  // is first displayed.
  await themeController.loadAll();
  // The app listens to the ThemeController for changes.
  runApp(ProviderScope(
    child: App(
      key: const ValueKey('RootApp'),
      themeController: themeController,
    ),
  ));

  if (kIsDesktop) {
    doWhenWindowReady(() {
      const initialSize = Size(600, 450);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = kAppTitle;
      appWindow.show();
    });
  }
}
