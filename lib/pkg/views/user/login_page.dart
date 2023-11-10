import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/pkg/service/apiservice.dart';
import 'package:flutter_application/pkg/views/common/home_page.dart';
import 'package:flutter_application/pkg/views/common/state.dart';
import 'package:flutter_application/pkg/views/common/util.dart';
import 'package:flutter_application/pkg/views/user/register.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';

  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // 登入請求API
    var apiService = ApiService(context);
    var response = await apiService.login(context, username, password);

    if (response.code == "0") {
      // 提取token
      String token = response.data['token'];
      AuthBloc().logIn(token);
      // 登录成功，导航到HomePage
      if (!context.mounted) return;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    } else {
      // 登录失败，显示错误消息
      if (!context.mounted) return;
      DialogUtils.showAlertDialog(context, 'Login Faild', response.msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to the Login Page',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                ],
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _login(context),
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterPage.routeName);
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
