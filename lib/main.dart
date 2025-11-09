import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/core/utilites/styles/app_theme.dart';
import 'package:news_app/features/home_screen/presentation/view/screens/home_screen.dart';
import 'package:news_app/features/news_details/news_details.dart';
import 'package:news_app/features/settings/provider/language_provider.dart';
import 'package:news_app/features/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LanguageProvider languageProvider = LanguageProvider();
  await languageProvider.getLanguage();
  runApp(ChangeNotifierProvider(
      create: (_) => languageProvider, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of(context);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale(languageProvider.selectedLanguage),
      debugShowCheckedModeBanner: false,
      routes: {
        Splash.routeName: (_) => const Splash(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        NewsDetails.routeName: (_) => NewsDetails(),
      },
      initialRoute: Splash.routeName,
      theme: AppTheme.lightTheme,
    );
  }
}
