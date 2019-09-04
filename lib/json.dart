import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<LoginJson> fetchPost(mail,pass) async {
  var response =
      await http.get('https://willingly.tk/inc/php/logincheck.php?username=$mail&password=$pass');
  if (response.statusCode == 200) {
    return LoginJson.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }

}

Future<LoginJson> returnLogin(mail,pass){
  return fetchPost(mail, pass).then((e){
    return e;
  });
}
class LoginJson {
  bool status;
  String session;

  LoginJson({this.status,this.session});

  factory LoginJson.fromJson(Map<String, dynamic> json) {
    return LoginJson(
      status: json['Status'],
      session: json['SessionID'],
    );
  }
}


class LoginCheck {
  Future<LoginJson> post;

  LoginCheck({Key key,@required this.post});
}

//Name,Surname,UserName,Email,Password
class Post {
  final String name;
  final String surname;
  final String username;
  final String email;
  final String password;
  
  Post({this.name, this.surname, this.username, this.email, this.password});
 
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['Name'],
      surname: json['Surname'],
      username: json['UserName'],
      email: json['Email'],
      password: json['Password'],
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    map['Name'] = name;
    map['Surname'] = surname;
    map['UserName'] = username;
    map['Email'] = email;
    map['Password'] = password;
    return map;
  }
}
Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}



