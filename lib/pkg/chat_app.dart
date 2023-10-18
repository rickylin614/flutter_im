import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/views/common/auth_bloc.dart';
import 'package:flutter_application/pkg/views/common/navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => ChatAppState();

  static ChatAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<ChatAppState>();
}

class ChatAppState extends State<ChatApp> {
  Locale _locale = const Locale('zh', '');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: const NavigationBars(),
      ),
      theme: ThemeData.dark(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
      ],
      locale: _locale,
    );
  }
}
