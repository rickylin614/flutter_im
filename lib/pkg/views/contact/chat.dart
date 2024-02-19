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
  final ScrollController _scrollController = ScrollController();
  WebSocketChannel? channel;
  FocusNode? myFocusNode; // 創建 FocusNode
  String? userName; // 用戶名稱
  String? userId; // 用戶識別碼

  @override
  void initState() {
    super.initState();
    _initSocket();
    myFocusNode = FocusNode();
    print(widget.friendId);
  }

  void _initSocket() async {
    channel = await FriendService().createWebSocketConnect(context);
    userName = await SPHelper().getUserName();
    userId = await SPHelper().getUserId();
    channel?.stream.listen(
      (data) {
        setState(() {
          if (data is Uint8List) {
            String dataString = utf8.decode(data);
            Message msg = Message.fromJson(json.decode(dataString));
            messages.add(msg);
            pullDownScroll();
          }
        });
      },
      onDone: () {
        print('WebSocket is closed');
      },
      onError: (error) {
        print('Error: $error');
      },
    );
    // Send a 'connect' message when the WebSocket connection is established
    Message msg = Message.connectMsg(userName ?? '');
    channel?.sink.add(msg.toJson());
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
              _buildChatUI(context),
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

  Widget _buildChatUI(BuildContext context) {
    // 目前主題的未選中顏色
    Color? chatBackgroundColor = Theme.of(context).primaryColorLight;
    // TextStyle? bodyLarge = Theme.of(context).textTheme.bodyLarge;
    TextStyle? bodyMedium = Theme.of(context).textTheme.bodyMedium;
    TextStyle? bodySmall = Theme.of(context).textTheme.bodySmall;

    // 將原本的 build 方法內容放到這裡，並使用 channel 參數
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Align(
              child: Column(
                crossAxisAlignment: messages[index].sender == (userName ?? '')
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment:
                        messages[index].sender == (userName ?? '')
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    children: [
                      Text(
                        '${messages[index].sender}  ',
                        style: bodySmall,
                      ),
                      Text(
                        '${messages[index].createdAt}',
                        style: bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: chatBackgroundColor,
                    ),
                    child: Text(
                      messages[index].msgContent,
                      style: bodyMedium,
                    ),
                  ),
                ],
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
        Message msg = Message(
          sender: userName ?? '',
          senderId: userId ?? '',
          recipient: widget.friendName,
          recipientId: widget.friendId,
          msgContent: _controller.text,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          status: MessageStatus.normal,
          msgType: MessageType.singleChatType,
        );
        messages.add(msg);
        String data = msg.toJson();
        channel?.sink.add(data);
        _controller.text = "";
        pullDownScroll();
      });
    }
  }

  void pullDownScroll() {
    // Scroll to the bottom after adding messages
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 16)).then((value) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuart,
        );
      });
    }
  }

  @override
  void dispose() {
    myFocusNode?.dispose();
    _scrollController.dispose();
    channel?.sink.close();
    super.dispose();
  }
}
