import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Cubit<bool> {
  AuthBloc() : super(false);

  void logIn() => emit(true);
  void logOut() => emit(false);
}
