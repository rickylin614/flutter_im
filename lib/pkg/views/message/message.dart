import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/service/sphelper.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  MessageState createState() => MessageState();
}

class MessageState extends State<Message> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter token'),
            ),
            ElevatedButton(
              onPressed: () async {
                var scaffoldContext = context;
                SPHelper().logIn(_controller.text, 'test').then((_) {
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    const SnackBar(content: Text('Token set successfully')),
                  );
                });
              },
              child: const Text('Set Token'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FutureBuilder<String>(
                      future: SPHelper().getToken(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // 在等待 token 的時候顯示一個加載指示器
                        } else {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return AlertDialog(
                              title: const Text('Token'),
                              content: Text('Token: ${snapshot.data}'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                        }
                      },
                    );
                  },
                );
              },
              child: const Text('Get Token'),
            ),
          ],
        ),
      ),
    );
  }
}
