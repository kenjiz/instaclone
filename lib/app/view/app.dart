import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/l10n/l10n.dart';
import 'package:instaclone/login/view/login_page.dart';
import 'package:repository/repository.dart';

class App extends StatelessWidget {
  const App({
    required this.userRepository,
    super.key,
  });

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: userRepository),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: const AppTheme().theme,
        themeMode: ThemeMode.dark,
        darkTheme: const AppDarkTheme().theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const LoginPage(),
      ),
    );
  }
}
