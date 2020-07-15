import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:schedule_app/model/User.dart';
import 'package:schedule_app/services/AppLanguage.dart';
import 'package:schedule_app/services/AppLocalizations.dart';
import 'package:schedule_app/services/AuthService.dart';
import 'package:schedule_app/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp(
      appLanguage: appLanguage,
    ));
  });
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(
          builder: (context, model, child) {
            return MaterialApp(
              locale: model.appLocal,
              supportedLocales: [
                Locale('en'),
                Locale('th'),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              home: Wrapper(),
            );
          },
        ),
      ),
    );
  }
}
