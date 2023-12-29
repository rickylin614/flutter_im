class Friend {
  final String id;
  final String pUserId;
  final String pUserName;
  final String fUserId;
  final String fUserName;
  final String status;
  final bool mute;

  Friend(
      {required this.id,
      required this.pUserId,
      required this.pUserName,
      required this.fUserId,
      required this.fUserName,
      required this.status,
      required this.mute});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      pUserId: json['p_user_id'],
      pUserName: json['p_user_name'],
      fUserId: json['f_user_id'],
      fUserName: json['f_user_name'],
      status: json['status'],
      mute: json['mute'],
    );
  }
}
