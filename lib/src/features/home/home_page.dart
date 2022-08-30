import 'package:flutter/material.dart';
import 'package:ytstream_dlg/src/features/theme/controllers/theme_controller.dart';
import 'package:ytstream_dlg/src/features/theme/pages/theme_selection_page.dart';
import 'package:ytstream_dlg/src/localization/app.i18n.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ThemeController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'.i18n),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      ThemeSelectionPage(controller: widget.controller),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
