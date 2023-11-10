import 'package:flutter/material.dart';

class MaintainPage extends StatelessWidget {
  static const routeName = '/login';

  const MaintainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("維修中"),
        ),
      ),
    );
  }
}
