import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:schedule_app/model/User.dart';
import 'package:schedule_app/push_nofitications.dart';
import 'package:schedule_app/screens/addEvent.dart';
import 'package:schedule_app/screens/chatting.dart';
import 'package:schedule_app/screens/forgotPass.dart';
import 'package:schedule_app/screens/myProfile.dart';
import 'package:schedule_app/screens/report.dart';
import 'package:schedule_app/screens/search.dart';
import 'package:schedule_app/screens/signIn.dart';
import 'package:schedule_app/screens/signUp.dart';
import 'package:schedule_app/screens/updateData.dart';
import 'package:schedule_app/screens/welcome.dart';
import 'package:schedule_app/services/AppLanguage.dart';
import 'package:schedule_app/services/AppLocalizations.dart';
import 'package:schedule_app/services/AuthService.dart';
import 'package:schedule_app/services/NavigationService.dart';
import 'package:schedule_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();

  await appLanguage.fetchLocale();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp(
      locator: GetIt.instance,
      appLanguage: appLanguage,
    ));
  });
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  final GetIt locator;
  MyApp({this.appLanguage, this.locator});

  @override
  Widget build(BuildContext context) {
    locator.registerLazySingleton(() => PushNotificationsManager());
    locator.registerLazySingleton(() => NavigationService());
    PushNotificationsManager().init();
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(
          builder: (context, model, child) {
            return MaterialApp(
              navigatorKey: locator<NavigationService>().navigatorKey,
              onGenerateRoute: (routeSettings) {
                switch (routeSettings.name) {
                  case '/chat':
                    return MaterialPageRoute(
                        builder: (context) => ChattingScreen());
                  default:
                    return MaterialPageRoute(builder: (context) => Wrapper());
                }
              },
              initialRoute: '/',
              routes: {
                '/wrapper': (context) => Wrapper(),
                '/chat': (context) => ChattingScreen(),
                '/myProfile': (context) => MyProfileScreen(),
                '/search': (context) => SearchScreen(),
                '/report': (context) => ReportScreen(),
                '/welcome': (context) => WelcomeScreen(),
                '/signup': (context) => SignUpScreen(),
                '/signin': (context) => SignInScreen(),
                '/addEvent': (context) => AddEventScreen(),
                '/forgotpass': (context) => ForgotPassScreen(),
                '/updateData': (context) => UpdateDataScreen()
              },
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
