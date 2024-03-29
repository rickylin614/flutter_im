import 'dart:convert';

class Message {
  String? id;
  String? sender;
  String? senderId;
  String? recipient;
  String? recipientId;
  String msgContent;
  DateTime createdAt;
  DateTime updatedAt;
  MessageStatus status;
  MessageType msgType;

  Message({
    this.id,
    this.sender,
    this.senderId,
    this.recipient,
    this.recipientId,
    required this.msgContent,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.msgType,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sender: json['sender'],
      senderId: json['senderId'],
      recipient: json['recipient'],
      recipientId: json['recipientId'],
      msgContent: json['msgContent'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      status: MessageStatus.values[json['status']],
      msgType: MessageType.values[json['msgType']],
    );
  }

  factory Message.connectMsg(String sender) {
    return Message(
      msgContent: 'connect',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: MessageStatus.normal,
      msgType: MessageType.notificationChatType,
    );
  }

  String toJson() {
    final Map<String, dynamic> msgPackData = {
      'id': id,
      'sender': sender,
      'senderId': senderId,
      'recipient': recipient,
      'recipientId': recipientId,
      'msgContent': msgContent,
      // 'createdAt': createdAt.millisecondsSinceEpoch,
      // 'updatedAt': updatedAt.millisecondsSinceEpoch,
      'status': status.value,
      'msgType': msgType.value,
    };

    return json.encode(msgPackData);
  }
}

class MessageStatus {
  final int value;

  const MessageStatus._(this.value);

  static const MessageStatus normal = MessageStatus._(0);
  static const MessageStatus withdrawn = MessageStatus._(1);
  static const MessageStatus deleted = MessageStatus._(2);
  static const MessageStatus hidden = MessageStatus._(3);

  static List<MessageStatus> get values => [
        normal,
        withdrawn,
        deleted,
        hidden,
      ];
}

class MessageType {
  final int value;

  const MessageType._(this.value);

  static const MessageType singleChatType = MessageType._(1);
  static const MessageType groupChatType = MessageType._(2);
  static const MessageType superGroupChatType = MessageType._(3);
  static const MessageType notificationChatType = MessageType._(4);

  static List<MessageType> get values => [
        singleChatType,
        groupChatType,
        superGroupChatType,
        notificationChatType,
      ];
}
