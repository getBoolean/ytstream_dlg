import 'dart:io' as io;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

bool get kIsDesktop =>
    !kIsWeb &&
    (io.Platform.isWindows || io.Platform.isMacOS || io.Platform.isLinux);

String kAppTitle = 'YouTube Livestream Downloader';
String kAppTitleShort = 'YT Livestream Downloader';

const kCorderColor = Color(0xFF805306);

const kSupportedLocales = [
  Locale('en', 'US'),
];

const kLocalizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
