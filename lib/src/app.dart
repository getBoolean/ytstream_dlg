import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:ytstream_dlg/src/constants.dart';
import 'package:ytstream_dlg/src/desktop_app.dart';
import 'package:ytstream_dlg/src/features/theme/const/app_color.dart';
import 'package:ytstream_dlg/src/features/theme/const/app_data.dart';
import 'package:ytstream_dlg/src/features/theme/controllers/theme_controller.dart';
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
          child: home,
        ),
        debugShowCheckedModeBanner: false,
        themeMode: themeController.themeMode,
        localizationsDelegates: kLocalizationsDelegates,
        supportedLocales: kSupportedLocales,
        scrollBehavior: const AppScrollBehavior(),
        theme: FlexThemeData.light(
          colors: AppColor.customSchemes[themeController.schemeIndex].light,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurfaces,
          blendLevel: 5,
          appBarElevation: 0.5,
          subThemesData: themeController.useSubThemes
              ? FlexSubThemesData(
                  defaultRadius: themeController.defaultRadius,
                )
              : null,
          keyColors: FlexKeyColors(
            useKeyColors: themeController.useKeyColors,
            useSecondary: themeController.useSecondary,
            useTertiary: themeController.useTertiary,
            keepPrimary: themeController.keepPrimary,
            keepSecondary: themeController.keepSecondary,
            keepTertiary: themeController.keepTertiary,
          ),
          // In this example we use the values for visual density and font
          // from a single static source, so we can change it easily there.
          visualDensity: AppData.visualDensity,
          fontFamily: AppData.font,
          // Use predefined M3 typography while this issue is in effect:
          // https://github.com/flutter/flutter/issues/103864
          typography: Typography.material2021(
            platform: defaultTargetPlatform,
          ),
        ),
        darkTheme: FlexThemeData.dark(
          colors: AppColor.customSchemes[themeController.schemeIndex].dark,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurfaces,
          // We go with a slightly stronger blend in dark mode.
          blendLevel: 7,
          appBarElevation: 0.5,
          keyColors: FlexKeyColors(
            useKeyColors: themeController.useKeyColors,
            useSecondary: themeController.useSecondary,
            useTertiary: themeController.useTertiary,
            keepPrimary: themeController.keepDarkPrimary,
            keepSecondary: themeController.keepDarkSecondary,
            keepTertiary: themeController.keepDarkTertiary,
          ),
          subThemesData: themeController.useSubThemes
              ? FlexSubThemesData(
                  defaultRadius: themeController.defaultRadius,
                )
              : null,
          visualDensity: AppData.visualDensity,
          fontFamily: AppData.font,
          // Use predefined M3 typography while this issue is in effect:
          // https://github.com/flutter/flutter/issues/103864
          typography: Typography.material2021(
            platform: defaultTargetPlatform,
          ),
        ),
      ),
    );
  }
}
