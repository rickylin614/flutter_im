import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/service/friendservice.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatPage extends StatefulWidget {
  final String friendName;

  const ChatPage({Key? key, required this.friendName}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  // WebSocketChannel? channel;
  io.Socket? socket;

  @override
  void initState() {
    super.initState();
    _initSocket();
  }

  void _initSocket() async {
    socket = await _getSocket(context);
    setState(() {}); // 更新 UI
  }

  List<String> messages = [];

  Future<io.Socket> _getSocket(BuildContext context) async {
    // 取得channel api
    var socket = await FriendService().createConnect(context);
    // 監聽 'connect' 事件
    socket.on('connect', (_) {
      print('connect');
    });

    // 監聽 'message' 事件
    socket.on('message', (data) {
      messages.add(data);
      setState(() {}); // 更新 UI
      print(data);
    });
    return socket;
  }

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
            if (socket == null)
              const CircularProgressIndicator() // 顯示加載指示器
            else
              _buildChatUI(),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: 'Send a message'),
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
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Align(
            alignment: messages[index].startsWith('Friend:')
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: messages[index].startsWith('Friend:')
                    ? Colors.blue[100]
                    : Colors.green[100],
              ),
              child: Text(messages[index]),
            ),
          ),
        );
      },
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      socket?.emit('message', _controller.text);
      setState(() {
        messages.add('Me: ${_controller.text}');
      });
    }
  }

  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }
}
