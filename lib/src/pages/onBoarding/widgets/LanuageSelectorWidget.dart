import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mawaqit/generated/l10n.dart';
import 'package:mawaqit/i18n/AppLanguage.dart';
import 'package:mawaqit/src/helpers/mawaqit_icons_icons.dart';
import 'package:mawaqit/src/services/mosque_manager.dart';
import 'package:provider/provider.dart';

class OnBoardingLanguageSelector extends StatelessWidget {
  const OnBoardingLanguageSelector({Key? key, required this.onSelect}) : super(key: key);

  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    var locales = S.delegate.supportedLocales;
    var appLanguage = Provider.of<AppLanguage>(context);
    var mosqueManager = Provider.of<MosqueManager>(context);

    /// if the [langCode] is current used language
    bool isSelected(String langCode) => appLanguage.appLocal.languageCode == langCode;

    return Column(
      children: [
        SizedBox(height: 10),
        Text(
          S.of(context).appLang,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          S.of(context).descLang,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 5),
            child: ListView.separated(
              // shrinkWrap: true,
              // primary: false,
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              itemCount: locales.length,
              separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
              itemBuilder: (BuildContext context, int index) {
                var locale = locales[index];
                return Material(
                  child: InkWell(
                    onTap: () {
                      appLanguage.changeLanguage(locale, mosqueManager.mosqueId);
                      onSelect();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 1.0,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: isSelected(locale.languageCode) ? Theme.of(context).selectedRowColor : null,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          dense: true,
                          leading: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('assets/img/flag/${locale.languageCode}.png'),
                          ),
                          title: Text(
                            appLanguage.languageName(locale.languageCode),
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: isSelected(locale.languageCode)
                              ? Icon(
                                  MawaqitIcons.icon_checked,
                                  color: Theme.of(context).primaryColor,
                                )
                              : null,
                          selected: true,
                          tileColor: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
