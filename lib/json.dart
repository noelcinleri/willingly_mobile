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

class LoginJson {
  String status;

  LoginJson({this.status});

  factory LoginJson.fromJson(Map<String, dynamic> json) {
    return LoginJson(
      status: json['Status'],
    );
  }
}


class LoginCheck extends StatelessWidget {
  Future<LoginJson> post;

  LoginCheck({Key key,@required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoginJson>(
     future: post,
     builder: (context, snapshot) {
       if (snapshot.hasData) {
         return Text(snapshot.data.status.toString());
       } else if (snapshot.hasError) {
         return Text("${snapshot.error}");
       }

       return CircularProgressIndicator();
     },
    );
  }
}



