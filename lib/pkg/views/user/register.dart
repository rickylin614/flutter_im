import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/service/authservice.dart';
import 'package:flutter_application/pkg/views/common/util.dart';
import 'package:flutter_application/pkg/views/user/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/register';

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nicknameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();

    void register() async {
      final String email = emailController.text;
      final String nickname = nicknameController.text;
      final String password = passwordController.text;
      final String phoneNumber = phoneNumberController.text;
      final String username = usernameController.text;

      var response = await AuthService()
          .register(context, email, password, phoneNumber, username, nickname);

      if (!context.mounted) return;
      if (response.code == "0") {
        // 注册成功，导航到登录页面
        DialogUtils.showSuccessDialog(
          context,
          "恭喜",
          "註冊成功",
          () => Navigator.of(context).pushReplacementNamed(LoginPage.routeName),
        );
      } else {
        DialogUtils.showAlertDialog(
            context, response.msg, jsonEncode(response.data));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to the Register Page',
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nicknameController,
                decoration: const InputDecoration(labelText: 'Nickname'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
