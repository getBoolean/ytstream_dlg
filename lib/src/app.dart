import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:ytstream_dlg/src/constants.dart';
import 'package:ytstream_dlg/src/desktop_app.dart';
import 'package:ytstream_dlg/src/features/theme/controllers/theme_controller.dart';
import 'package:ytstream_dlg/src/features/theme/flex_theme_dark.dart';
import 'package:ytstream_dlg/src/features/theme/flex_theme_light.dart';
import 'package:ytstream_dlg/src/features/theme/theme_data_dark.dart';
import 'package:ytstream_dlg/src/features/theme/theme_data_light.dart';
import 'package:ytstream_dlg/src/features/theme/utils/app_scroll_behavior.dart';
import 'package:ytstream_dlg/src/mobile_app.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.themeController}) : super(key: key);

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final Widget home;
    if (kIsDesktop) {
      home = DesktopApp(controller: themeController);
    } else {
      home = MobileApp(controller: themeController);
    }

    return AnimatedBuilder(
      key: const ValueKey('RootAnimatedBuilder'),
      animation: themeController,
      builder: (BuildContext context, Widget? child) => MaterialApp(
        key: const ValueKey('RootMaterialApp'),
        title: kAppTitle,
        home: I18n(
          key: const ValueKey('RootI18n'),
          child: SelectionArea(child: home),
        ),
        debugShowCheckedModeBanner: false,
        themeMode: themeController.themeMode,
        localizationsDelegates: kLocalizationsDelegates,
        supportedLocales: kSupportedLocales,
        scrollBehavior: const AppScrollBehavior(),
        theme: themeController.useFlexColorScheme
            ? flexThemeLight(themeController)
            : themeDataLight(themeController),
        darkTheme: themeController.useFlexColorScheme
            ? flexThemeDark(themeController)
            : themeDataDark(themeController),
      ),
    );
  }
}
