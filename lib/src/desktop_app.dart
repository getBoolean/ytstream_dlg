import 'dart:io' as io;

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:system_tray/system_tray.dart';
import 'package:ytstream_dlg/src/constants.dart';
import 'package:ytstream_dlg/src/features/theme/controllers/theme_controller.dart';
import 'package:ytstream_dlg/src/features/theme/pages/theme_selection_page.dart';
import 'package:ytstream_dlg/src/localization/app.i18n.dart';

class DesktopApp extends StatefulWidget {
  const DesktopApp({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ThemeController controller;

  @override
  State<DesktopApp> createState() => _DesktopAppState();
}

class _DesktopAppState extends State<DesktopApp> {
  @override
  void initState() {
    super.initState();
    initSystemTray();
  }

  @override
  Widget build(BuildContext context) {
    return DesktopHome(controller: widget.controller);
  }

  Future<void> initSystemTray() async {
    final String path =
        io.Platform.isWindows ? 'assets/app_icon.ico' : 'assets/app_icon.png';

    final AppWindow appWindow = AppWindow();
    final SystemTray systemTray = SystemTray();

    // We first init the systray menu
    await systemTray.initSystemTray(
      title: 'system tray',
      iconPath: path,
      toolTip: kAppTitle.i18n,
    );

    // create context menu
    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLable(label: 'Show', onClicked: (menuItem) => appWindow.show()),
      MenuItemLable(label: 'Hide', onClicked: (menuItem) => appWindow.hide()),
      MenuItemLable(label: 'Exit', onClicked: (menuItem) => appWindow.close()),
    ]);

    // set context menu
    await systemTray.setContextMenu(menu);

    // handle system tray event
    systemTray.registerSystemTrayEventHandler((eventName) {
      debugPrint('eventName: $eventName');
      if (eventName == kSystemTrayEventClick) {
        io.Platform.isWindows
            ? appWindow.show()
            : systemTray.popUpContextMenu();
      } else if (eventName == kSystemTrayEventRightClick) {
        io.Platform.isWindows
            ? systemTray.popUpContextMenu()
            : appWindow.show();
      }
    });
  }
}

class DesktopHome extends StatelessWidget {
  const DesktopHome({Key? key, required this.controller}) : super(key: key);

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        color: kCorderColor,
        width: 1,
        child: Row(
          children: [LeftSide(controller: controller), const RightSide()],
        ),
      ),
    );
  }
}

const sidebarColor = Color(0xFFF6A00C);

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key, required this.controller}) : super(key: key);

  final ThemeController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        color: sidebarColor,
        child: Column(
          children: [
            WindowTitleBarBox(
              child: MoveWindow(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(kAppTitleShort.i18n),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      child: const Text('Settings'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                ThemeSelectionPage(controller: controller),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

const backgroundStartColor = Color(0xFFFFD500);
const backgroundEndColor = Color(0xFFF6A00C);

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundStartColor, backgroundEndColor],
              stops: [0.0, 1.0]),
        ),
        child: Column(children: [
          WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(child: MoveWindow()),
                const WindowButtons(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(
          colors: closeButtonColors,
          onPressed: () {
            appWindow.hide();
          },
        ),
      ],
    );
  }

  // TODO: Add option to change close button to actually close the window
  // void closeConfirmation(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return AlertDialog(
  //         title: const Text(
  //             'Are you sure you want to close this application? Any downloads in progress will be corrupted'),
  //         actions: [
  //           TextButton(
  //             child: const Text('No'),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //           ElevatedButton(
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.resolveWith<Color>(
  //                 (Set<MaterialState> states) {
  //                   if (states.contains(MaterialState.pressed)) {
  //                     return Theme.of(context)
  //                         .colorScheme
  //                         .primary
  //                         .withOpacity(0.5);
  //                   }
  //                   return Colors.red;
  //                 },
  //               ),
  //             ),
  //             child: const Text('Yes'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               appWindow.close();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
