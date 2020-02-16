import 'dart:async';

import 'package:Mafruka/locale/app_translation.dart';
import 'package:Mafruka/locale/application.dart';
import 'package:Mafruka/modules/core/middleware/home_middleware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';

import 'locale/app_translations_delegate.dart';
import 'modules/core/middleware/navigation_key.dart';
import 'modules/core/middleware/navigation_middleware.dart';
import 'modules/core/models/app_state.dart';
import 'modules/core/reducers/app_state_reducer.dart';
import 'modules/core/screens/splash_screen.dart';
import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bool isInDebugMode = false;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
  runZoned<Future<Null>>(() async {
    runApp(MafrukaApp());
  }, onError: (error, stackTrace) async {
    print("Error: " + error.toString());
    print(stackTrace.toString());
  });
}

loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('${DateTime.now()} $action ');
  next(action);
}

AppState init() => AppState();

class MafrukaApp extends StatefulWidget {
  @override
  MafrukaAppState createState() => MafrukaAppState();
}

class MafrukaAppState extends State<MafrukaApp> {
  AppTranslationsDelegate newLocaleDelegate;
  final store = Store<AppState>(appStateReducer,
      initialState: init(),
      middleware: [loggingMiddleware, navigationMiddleware, homeMiddleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          localizationsDelegates: [
            const AppTranslationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: application.supportedLocales(),
          localeResolutionCallback:
              (Locale locale, Iterable<Locale> supportedLocales) {
            for (Locale supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.last;
          },
          theme: ThemeData(
              textTheme:
                  GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme)),
          initialRoute: '/',
          navigatorKey: navigatorKey,
          title: "Mafruka",
          builder: (context, child) {
            return Directionality(
              textDirection: AppTranslations.of(context).currentLanguage == "ar"
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Builder(
                builder: (context) {
                  return MediaQuery(
                    child: child,
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.0,
                    ),
                  );
                },
              ),
            );
          },
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          routes: routes(),
        ));
  }
}
