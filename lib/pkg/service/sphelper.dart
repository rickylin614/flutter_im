import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPHelper extends Cubit<bool> {
  SPHelper() : super(false);

  Future<void> logIn(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', value);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<bool> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('token');
  }
}
