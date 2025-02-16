import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/theme.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class HandMadeCakeApp extends StatelessWidget {
  const HandMadeCakeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth != 0) {
          return MaterialApp(
            // app default option
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,

            // 시스템 테마 설정 (라이트, 다크 모드)
            theme: AppTheme.lightTheme.copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: getColorScheme(context).colorPrimary500,
                selectionColor: getColorScheme(context).colorPrimary500.withOpacity(0.2),
              ),
              dialogTheme: DialogTheme(
                backgroundColor: getColorScheme(context).white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            darkTheme: AppTheme.darkTheme.copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: getColorScheme(context).colorPrimary500,
                selectionColor: getColorScheme(context).colorPrimary500.withOpacity(0.2),
              ),
            ),
            themeMode: ThemeMode.system,

            // 앱 Localization ( 한국어 지원 )
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,

            debugShowCheckedModeBanner: true,

            initialRoute: RoutingScreen.Splash.route,
            routes: RoutingScreen.getAppRoutes(),

            navigatorKey: HandMadeCakeGlobalVariable.naviagatorState,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class HandMadeCakeGlobalVariable {
  static final GlobalKey<NavigatorState> naviagatorState = GlobalKey<NavigatorState>();
}
