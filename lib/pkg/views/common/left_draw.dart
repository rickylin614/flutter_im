import 'package:flutter/material.dart';

class LeftDraw extends StatefulWidget {
  const LeftDraw({super.key});

  @override
  State<LeftDraw> createState() => _LeftDrawState();
}

class _LeftDrawState extends State<LeftDraw> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('选项 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('选项 2'),
            onTap: () {
              // 处理选项 2 的操作
            },
          ),
        ],
      ),
    );
  }
}
