import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

    void getHttp(data) async {
      Dio dio = Dio();
      await dio
          .get('http://localhost:9000/im/users/register', data: data)
          .then((response) {
        print(response.data);
      }).catchError((error) {
        print('Error: $error');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nicknameController,
                decoration: const InputDecoration(labelText: 'Nickname'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final registerData = {
                    "email": emailController.text,
                    "nickname": nicknameController.text,
                    "password": passwordController.text,
                    "phone_number": phoneNumberController.text,
                    "username": usernameController.text,
                  };
                  getHttp(registerData);

                  // 发送注册数据到服务器，可以使用 http 包或其他网络请求库
                  // 处理注册逻辑，检查响应并导航到成功或失败页面
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
