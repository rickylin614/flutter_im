import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/views/common/home_page.dart';
import 'package:flutter_application/pkg/views/user/login_page.dart';
import 'package:flutter_application/pkg/views/user/register.dart';

class AppRouter {
  static var routes = <String, WidgetBuilder>{
    "/login": (context) => LoginPage(),
    "/register": (context) => const RegisterPage(),
    "/": (context) => const HomePage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // 可根据权限判断来导航到路由
    // final bool hasToken = /* 根据实际情况检查是否存在 token */;
    const hasToken = true;

    if (routes[settings.name] != null) {
      return MaterialPageRoute(builder: routes[settings.name]!);
    }

    return MaterialPageRoute(builder: (context) {
      if (hasToken) {
        return const HomePage();
      } /* else {
      return const LoginPage();
    }*/
    });
  }
}
