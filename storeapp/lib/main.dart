import 'package:atomicdesign/ui/foundation/theme_foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/viewmodel/init_session_viewmodel.dart';
import 'infraestructure/local/preferences.dart';
import 'ui/navigation/routes.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => InitSessionViewModel(pref: Preferences()),
      child: const MyAppWithState(),
      );
  }
}

class MyAppWithState extends StatelessWidget {
  const MyAppWithState({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store App',
      theme: basicLightThemeFoundation,
      darkTheme: basicDarkThemeFoundation,
      themeMode: ThemeMode.light,
      routes: appRoutes,
    );
  }
}


