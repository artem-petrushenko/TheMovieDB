import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:themoviedb/src/common/widget/navigation/navigation.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required Navigation navigation,
  })  : _navigation = navigation,
        super(key: key);

  final Navigation _navigation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ru', 'RU'),
      ],
      routes: _navigation.routes,
      initialRoute: MainNavigationRouteNames.loaderScreen,
      onGenerateRoute: _navigation.onGenerateRoute,
    );
  }
}
