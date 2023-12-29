import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/service/sphelper.dart';
import 'package:flutter_application/pkg/views/common/home_page.dart';
import 'package:flutter_application/pkg/views/user/login_page.dart';
import 'package:flutter_application/pkg/views/user/register.dart';

class AppRouter {
  static var routes = <String, WidgetBuilder>{
    "/login": (context) => LoginPage(),
    "/register": (context) => const RegisterPage(),
    // "/": (context) => const HomePage(), // 不匹配時套用onGenerateRoute
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      return FutureBuilder<String>(
        future: SPHelper().getToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // 在等待 token 的時候顯示一個加載指示器
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                return const HomePage();
              } else {
                return LoginPage();
              }
            }
          }
        },
      );
    });
  }
}
