import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/l10n/l10n.dart';
import 'package:instaclone/login/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: const AppTheme().theme,
      themeMode: ThemeMode.light,
      darkTheme: const AppDarkTheme().theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SafeArea(
        child: Scaffold(
          body: LoginPage(),
        ),
      ),
    );
  }
}
