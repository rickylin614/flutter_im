// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/model/message.dart';
import 'package:flutter_application/pkg/service/friendservice.dart';
import 'package:flutter_application/pkg/service/sphelper.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  final String friendName;
  final String friendId;

  const ChatPage({Key? key, required this.friendName, required this.friendId})
      : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  WebSocketChannel? channel;
  FocusNode? myFocusNode; // 創建 FocusNode

  @override
  void initState() {
    super.initState();
    _initSocket();
    myFocusNode = FocusNode();
  }

  void _initSocket() async {
    channel = await FriendService().createWebSocketConnect(context);
    channel?.stream.listen(
      (data) {
        setState(() {
          // Update UI with received messages
          // messages.add('Friend: ${data.toString()}');
          // messages.add(
          // Message(sender: 'Friend', msgContent: data.toString(), isMine: false));
          if (data is Uint8List) {
            String dataString = utf8.decode(data);
            Message msg = Message.fromJson(json.decode(dataString));
            SPHelper().getUserName().then((name) {
              if (msg.sender == name) {
                msg.isMine = true;
              }
              messages.add(msg);
            });
          }
        });
        print(data);
      },
      onDone: () {
        print('WebSocket is closed');
      },
      onError: (error) {
        print('Error: $error');
      },
    );

    // Send a 'connect' message when the WebSocket connection is established
    channel?.sink.add('connect');
  }

  List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.friendName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            if (channel == null)
              const CircularProgressIndicator()
            else
              _buildChatUI(),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: myFocusNode,
                    decoration:
                        const InputDecoration(hintText: 'Send a message'),
                    onSubmitted: (text) {
                      _sendMessage();
                      myFocusNode?.requestFocus();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChatUI() {
    // 將原本的 build 方法內容放到這裡，並使用 channel 參數
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Align(
              alignment: messages[index].isMine
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: messages[index].isMine
                      ? Colors.blue[100]
                      : Colors.green[100],
                ),
                child: Text(
                    '${messages[index].sender}: ${messages[index].msgContent}'),
              ),
            ),
          );
        },
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // channel?.sink.add('message: ${_controller.text}');
      setState(() {
        // messages
        //     .add(Message(sender: 'Me', msg: _controller.text, isMine: true));
        SPHelper().getUserName().then((name) {
          Message msg = Message(
            sender: name,
            recipient: widget.friendName,
            msgContent: _controller.text,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            status: MessageStatus.normal,
            msgType: MessageType.singleChatType,
          );
          String data = msg.toJson();
          channel?.sink.add(data);
          _controller.text = "";
        });
      });
    }
  }

  @override
  void dispose() {
    myFocusNode?.dispose();
    channel?.sink.close();
    super.dispose();
  }
}

// class Message {
//   final String sender;
//   final String type;
//   final String msg;
//   final bool isMine;

//   Message(
//       {required this.sender,
//       required this.msg,
//       this.type = 'message',
//       required this.isMine});
// }
