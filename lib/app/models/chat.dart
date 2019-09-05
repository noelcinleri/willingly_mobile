import 'package:willingly/app/models/user.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

import 'package:willingly/json.dart';

Future<Post> fetchPost() async {
  var http;
  final response =
      //Buraya kendi php ni ekliyecez
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Chat {
  int id, userId, unreadCount;
  String userName, userImage;
  String message;

  Chat({this.id, this.userId, this.userName, this.userImage, this.unreadCount, this.message});

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      userId: json['userId'],
      id: json['id'],
      userName: json['userName'],
      userImage: json['userImage'],
      unreadCount: json['unreadCount'],
      message: json['message'],
    );
  }
  //Chat(this.id, this.userId, this.userName, this.userImage, this.unreadCount, this.message);
}

List<Chat> chats = [
  //Yukardaki Seyleri buraya listele sonra chats.dart da goster
  Chat(),
];