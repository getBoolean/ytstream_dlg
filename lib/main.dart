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
  // Use a ThemeController, which glues our theme settings to Flutter Widgets.
  //
  // The controller uses an abstract ThemeService interface to get and save the
  // settings. There are 3 implementations available to choose from:
  //
  // 0. ThemeService      - Abstract interface base class.
  // 1. ThemeServiceMem   - Only keeps settings in memory.
  // 2. ThemeServicePrefs - Persist settings locally using SharedPreferences.
  // 3. ThemeServiceHive  - Persist settings locally using Hive.
  //
  // Here we use Hive. The examples are all built using same
  // "example" app. If we use SharedPreferences in more than one of the apps
  // they would use the same storage container and share the settings when you
  // build them locally. By using Hive for most examples, we can change
  // the storage container name for each example. In these demos the
  // SharedPreferences service is only used for example 3, but you can swap in
  // the Hive based one for it as well.

  // The ThemeServiceHive constructor requires a box name, the others do not.
  // The box name is just a file name for the file that stores the settings.
  final ThemeService themeService =
      ThemeServiceHive('flex_color_scheme_v5_box_4');
  // Initialize the theme service.
  await themeService.init();
  // Create a ThemeController that uses the ThemeService.
  final ThemeController themeController = ThemeController(themeService);
  // Load all the preferred theme settings, while the app is loading, before
  // MaterialApp is created. This prevents a sudden theme change when the app
  // is first displayed.
  await themeController.loadAll();
  // Run the app and pass in the ThemeController. The app listens to the
  // ThemeController for changes.
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
