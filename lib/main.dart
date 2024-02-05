import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/chat_app.dart';
import 'package:flutter_application/pkg/service/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: const ChatApp(),
    ),
  );
}
