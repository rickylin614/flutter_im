import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPHelper extends Cubit<bool> {
  SPHelper() : super(false);

  Future<void> logIn(String token, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('name', name);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? '';
  }

  Future<bool> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    final nameRemoved = await prefs.remove('name');
    final tokenRemoved = await prefs.remove('token');
    return Future<bool>.value(nameRemoved && tokenRemoved);
  }
}
