import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:ytstream_dlg/src/features/theme/const/app_color.dart';
import 'package:ytstream_dlg/src/features/theme/const/app_data.dart';
import 'package:ytstream_dlg/src/features/theme/controllers/theme_controller.dart';
import 'package:ytstream_dlg/src/features/theme/widgets/page_body.dart';
import 'package:ytstream_dlg/src/features/theme/widgets/switch_list_tile_adaptive.dart';
import 'package:ytstream_dlg/src/features/theme/widgets/theme_popup_menu.dart';
import 'package:ytstream_dlg/src/features/theme/widgets/theme_showcase.dart';
import 'package:ytstream_dlg/src/features/theme/widgets/use_key_colors_buttons.dart';
import 'package:ytstream_dlg/src/localization/app.i18n.dart';

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({
    super.key,
    required this.controller,
  });

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final double margins =
        AppData.responsiveInsets(MediaQuery.of(context).size.width);
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headlineMedium = textTheme.headlineMedium!;

    return Row(
      children: <Widget>[
        const SizedBox(width: 0.01),
        Expanded(
          // Wrapping the Scaffold in a Row, with an almost zero width SizedBox
          // before the Scaffold that is in an Expanded widget so it fills the
          // available screen, causes the PopupMenu to open up right aligned on
          // its ListTile child used as its activation button. Without this, it
          // is always left aligned on the ListTile and would require a
          // computed offset. This trick, or maybe a bit of a hack, does it
          // automatically. No idea why, just something I noticed by accident.
          child: Scaffold(
            appBar: AppBar(
              title: Text('Theme Selection'.i18n),
              // TODO: Add an about icon
              // actions: const <Widget>[AboutIconButton()],
            ),
            body: PageBody(
              constraints: const BoxConstraints(maxWidth: AppData.maxBodyWidth),
              child: ListView(
                primary: true,
                padding: EdgeInsets.all(margins),
                children: <Widget>[
                  // Wrap these in a card for a nice design effect.
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: margins,
                        horizontal: margins + 4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // A 3-way theme toggle switch that shows the scheme.
                          FlexThemeModeSwitch(
                            themeMode: controller.themeMode,
                            onThemeModeChanged: controller.setThemeMode,
                            flexSchemeData:
                                AppColor.customSchemes[controller.schemeIndex],
                            optionButtonBorderRadius:
                                controller.useSubThemes ? 12 : 4,
                            buttonOrder:
                                FlexThemeModeButtonOrder.lightSystemDark,
                          ),
                          // Theme popup menu button to select color scheme.
                          ThemePopupMenu(
                            contentPadding: EdgeInsets.zero,
                            schemeIndex: controller.schemeIndex,
                            onChanged: controller.setSchemeIndex,
                          ),
                          // TODO: Create ShowColorSchemeColors
                          // Active theme color indicators.
                          // const ShowColorSchemeColors(),
                          // const SizedBox(height: 8),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Use input colors as keys '
                                'for the ColorScheme'),
                            subtitle:
                                Text(AppColor.explainUsedColors(controller)),
                          ),
                          // const SizedBox(height: 4),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            trailing: UseKeyColorsButtons(
                              controller: controller,
                            ),
                          ),
                          if (isLight) ...<Widget>[
                            SwitchListTileAdaptive(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Keep primary color'),
                              value: controller.useKeyColors &&
                                  controller.keepPrimary,
                              onChanged: controller.useKeyColors
                                  ? controller.setKeepPrimary
                                  : null,
                            ),
                            SwitchListTileAdaptive(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Keep secondary color'),
                              value: controller.useKeyColors &&
                                  controller.keepSecondary,
                              onChanged: controller.useKeyColors
                                  ? controller.setKeepSecondary
                                  : null,
                            ),
                            SwitchListTileAdaptive(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Keep tertiary color'),
                              value: controller.useKeyColors &&
                                  controller.keepTertiary,
                              onChanged: controller.useKeyColors
                                  ? controller.setKeepTertiary
                                  : null,
                            ),
                          ] else ...<Widget>[
                            SwitchListTileAdaptive(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Keep primary color'),
                              value: controller.useKeyColors &&
                                  controller.keepDarkPrimary,
                              onChanged: controller.useKeyColors
                                  ? controller.setKeepDarkPrimary
                                  : null,
                            ),
                            SwitchListTileAdaptive(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Keep secondary color'),
                              value: controller.useKeyColors &&
                                  controller.keepDarkSecondary,
                              onChanged: controller.useKeyColors
                                  ? controller.setKeepDarkSecondary
                                  : null,
                            ),
                            SwitchListTileAdaptive(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Keep tertiary color'),
                              value: controller.useKeyColors &&
                                  controller.keepDarkTertiary,
                              onChanged: controller.useKeyColors
                                  ? controller.setKeepDarkTertiary
                                  : null,
                            ),
                          ],
                          SwitchListTileAdaptive(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Use component themes'),
                            subtitle: const Text(
                                'Enable opinionated widget sub themes'),
                            value: controller.useSubThemes,
                            onChanged: controller.setUseSubThemes,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            enabled: controller.useSubThemes &&
                                controller.useFlexColorScheme,
                            title:
                                const Text('Used border radius on UI elements'),
                            subtitle: const Text(
                                'Default uses Material 3 specification border '
                                'radius, which varies per component. '
                                'A defined value sets it for all components. '
                                'Material 2 specification is 4.'),
                          ),
                          ListTile(
                            enabled: controller.useSubThemes &&
                                controller.useFlexColorScheme,
                            contentPadding: EdgeInsets.zero,
                            title: Slider.adaptive(
                              min: -1,
                              max: 30,
                              divisions: 31,
                              label: controller.defaultRadius == null ||
                                      (controller.defaultRadius ?? -1) < 0
                                  ? 'default'
                                  : (controller.defaultRadius
                                          ?.toStringAsFixed(0) ??
                                      ''),
                              value: controller.useSubThemes &&
                                      controller.useFlexColorScheme
                                  ? controller.defaultRadius ?? -1
                                  : 4,
                              onChanged: controller.useSubThemes &&
                                      controller.useFlexColorScheme
                                  ? (double value) {
                                      controller.setDefaultRadius(
                                          value < 0 ? null : value);
                                    }
                                  : null,
                            ),
                            trailing: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'RADIUS',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    controller.useSubThemes &&
                                            controller.useFlexColorScheme
                                        ? controller.defaultRadius == null ||
                                                (controller.defaultRadius ??
                                                        -1) <
                                                    0
                                            ? 'default'
                                            : (controller.defaultRadius
                                                    ?.toStringAsFixed(0) ??
                                                '')
                                        : '4',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Open some sub-pages
                  // TODO: Maybe show subpages?
                  // const ShowSubPages(),
                  // const SizedBox(height: 8),
                  const Divider(),
                  Text('Theme Showcase', style: headlineMedium),
                  ThemeShowcase(
                    useRailAssertWorkAround: !controller.useSubThemes,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
