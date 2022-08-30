import 'package:i18n_extension/i18n_extension.dart';

import 'package:ytstream_dlg/src/constants.dart';

const String kLegalese = 'Legal stuff here.';

extension Localization on String {
  // Example in English. It is not required to enter it in for English
  static final _t = Translations.byLocale('en_us') +
          {
            'en_us': {
              kAppTitle: kAppTitle,
              kAppTitleShort: kAppTitleShort,
              kLegalese: 'Blah blah.',
            },
          }
      // +
      // {
      //   'language_code': {
      //     'Original string': 'Translated string',
      //   }
      // }
      ;

  String get i18n => localize(this, _t);

  /// String interpolation parameters
  String fill(List<Object> params) => localizeFill(this, params);

  /// Show different text based on the number
  String plural(int value) => localizePlural(value, this, _t);

  // Custom modifier based on enums
  // String version(Object modifier) => localizeVersion(modifier, this, _t);

  /// Returns a map of all translated strings, where modifiers are the keys.
  /// In special, the unversioned text is indexed with a `null` key.
  Map<String?, String> allVersions() => localizeAllVersions(this, _t);
}
