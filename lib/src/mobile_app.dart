import 'package:flutter/material.dart';
import 'package:ytstream_dlg/src/features/home/home_page.dart';
import 'package:ytstream_dlg/src/features/theme/controllers/theme_controller.dart';

class MobileApp extends StatefulWidget {
  const MobileApp({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ThemeController controller;

  @override
  State<MobileApp> createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> {
  @override
  Widget build(BuildContext context) {
    return MobileHome(controller: widget.controller);
  }
}

class MobileHome extends StatefulWidget {
  const MobileHome({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ThemeController controller;

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(controller: widget.controller),
    );
  }
}
