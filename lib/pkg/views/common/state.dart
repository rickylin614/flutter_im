import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/chat_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Cubit<bool> {
  AuthBloc() : super(true);

  void logIn() => emit(true);
  void logOut() => emit(false);
}

class ThemeBloc extends Cubit<ThemeData> {
  ThemeBloc() : super(ThemeData.light());

  bool _isDarkTheme = false; // 添加一个属性来表示主题模式

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme(BuildContext context) {
    _isDarkTheme = !_isDarkTheme;
    emit(_isDarkTheme ? ThemeData.dark() : ThemeData.light());
    ChatApp.of(context)?.toggleTheme();
  }
}
