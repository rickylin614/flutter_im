import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/model/datapage.dart';
import 'package:flutter_application/pkg/model/friend.dart';
import 'package:flutter_application/pkg/service/friendservice.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  // 假設這是您的好友列表
  final List<Map<String, dynamic>> friends = [
    {'name': '好友1', 'icon': Icons.person},
    {'name': '好友2', 'icon': Icons.person},
    {'name': '好友3', 'icon': Icons.person},
    {'name': '好友4', 'icon': Icons.person},
    {'name': '好友5', 'icon': Icons.person},
    // 添加更多好友...
  ];

  void _getList(BuildContext context) async {
    // 登入請求API
    var response = await FriendService().getFriendList(context);
    var result =
        DataPage.fromJson(response.data, (json) => Friend.fromJson(json));
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    _getList(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(friends[index]['icon']),
            title: Text(friends[index]['name']),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                // 處理選項的點擊事件
                print('選擇了: $value');
              },
              itemBuilder: (BuildContext context) {
                return ['選項1', '選項2', '選項3'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
            onTap: () {
              // 點擊事件，進入好友對話頁面
              print('點擊了: ${friends[index]['name']}');
            },
          );
        },
      ),
    );
  }
}
