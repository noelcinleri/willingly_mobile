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
Future<Post> createPost({Map body}) async {

  String url='https://willingly.tk/inc/php/Insert_CreateNewUser.php';
  return http.post(url, headers:{'Content-Type':'application/x-www-form-urlencoded'},body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}




class BaseModel {
  int status;
  String message;
  String response;

  List<Movie> list;

  BaseModel.map(dynamic obj) {
    if (obj != null) {
      this.status = obj["status"];
      if (status == null) {
        this.status = obj["status_code"];
      }
      this.message = obj["message"];
      this.response =
          obj["response"] != null ? obj["response"].toString() : null;
    }
  }

  BaseModel.searchResult(dynamic obj) {
    list = obj.map<Movie>((json) => new Movie.fromJson(json)).toList();
  }
}
NetworkUtil _netUtil = new NetworkUtil();

  Future<BaseModel> search(String query) {
    String bASE_TOKEN_URL = NetworkUtil.BASE_URL + "search/movie";
    return _netUtil.post(bASE_TOKEN_URL, body: {
      "api_key": "put_your_key_here",
      "query": query,
    }).then((dynamic res) {
      var results = new BaseModel.searchResult(res["results"]);
      results.status = 200;
      return results;
    });
  }
class NetworkUtil {

  static final BASE_URL = "https://api.themoviedb.org/3/";

  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url, {Map<String, String> headers, encoding}) {
    return http
        .get(
      url,
      headers: headers,
    )
        .then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":"+
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception( statusCode);
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url,
      {Map<String, String> headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" +
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception( statusCode);
      }
      return _decoder.convert(res);
    });
  }

}

class Movie extends Object {
  int id;
  String title;
  String original_title;
  String poster_path;

  Movie({
    this.id,
    this.title,
    this.original_title,
    this.poster_path,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return new Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      original_title: json['original_title'] as String,
      poster_path: json['poster_path'] as String,
    );
  }
}
