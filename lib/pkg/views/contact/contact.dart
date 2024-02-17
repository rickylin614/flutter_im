// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/model/datapage.dart';
import 'package:flutter_application/pkg/model/friend.dart';
import 'package:flutter_application/pkg/service/friendservice.dart';
import 'package:flutter_application/pkg/views/contact/chat.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  // 假設這是您的好友列表
  List<Friend> friends = [];

  @override
  void initState() {
    super.initState();
    _getList(context);
  }

  void _getList(BuildContext context) async {
    // 登入請求API
    var response = await FriendService().getFriendList(context);
    var result =
        DataPage.fromJson(response.data, (json) => Friend.fromJson(json));
    setState(() {
      friends = result.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(friends[index].fUserName),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    friendName: friends[index].fUserName,
                    friendId: friends[index].fUserId,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
