import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/chat_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// APP 存機密資料才用
class AuthBloc extends Cubit<bool> {
  final _storage = const FlutterSecureStorage();

  AuthBloc() : super(false) {
    _checkLoggedInStatus();
  }

  Future<void> _checkLoggedInStatus() async {
    final isLoggedIn = await _storage.read(key: 'isLoggedIn') == 'true';
    emit(isLoggedIn);
  }

  Future<void> logIn(String token) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'isLoggedIn', value: 'true');
    emit(true);
  }

  Future<void> logOut() async {
    await _storage.delete(key: 'token');
    await _storage.write(key: 'isLoggedIn', value: 'false');
    emit(false);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
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
