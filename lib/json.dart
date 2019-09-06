import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:willingly/app/utils/sessionId.dart';

Future<LoginJson> fetchPost(mail,pass) async {
  var response =
      await http.get('https://willingly.tk/inc/php/logincheck.php?email=$mail&password=$pass', headers:{'Content-Type':'application/x-www-form-urlencoded','Accept':'*/*'});
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
  bool statu;
  String id;
  Post({this.name, this.surname, this.username, this.email, this.password, this.statu, this.id});
 
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      statu: json['Status'],
      id: json['SessionId'],
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
Future postDeneme(Map _body) async {
  print("body : "+_body.toString());
  String url='https://willingly.tk/inc/php/Insert_CreateNewUser.php';
  return http.post(url, headers:{'Content-Type':'application/x-www-form-urlencoded'},body: _body ).then((http.Response response) {

    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}

//KATEGOR İŞLEMLERİ
class Category {
  final String id;
  final String name;
  final String desc;
  final bool status;
  Category({this.id, this.name,this.status,this.desc});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['Id'] as String,
      name: json['Name'] as String,
      desc: json['Desc'] as String,
      status: json['Status'] as bool,
    );
  }
}
List<Category> parseCategory(String responseBody) {
  final parsed = json.decode(responseBody)['Catagory'].cast<Map<String, dynamic>>();

  return parsed.map<Category>((json) => Category.fromJson(json)).toList();
}

Future<List<Category>> fetchCategory() async {
  final response =
      await http.get('https://willingly.tk/inc/php/Get_FilterConfig.php');
  if (response.statusCode == 200) {
    return   parseCategory(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}
class CategoryPost{
  final String id , categoryIdGet;
  final int userId;
  final String title , explanation,price,donationPrice,advertisementRate,advertisementSkills;

  CategoryPost({this.id, this.categoryIdGet, this.userId, this.title, this.explanation, this.price, this.donationPrice, this.advertisementRate, this.advertisementSkills,});

  factory CategoryPost.fromJson(Map<String, dynamic> parsedJson) {
    return CategoryPost(
      id: parsedJson['Id'],
      userId: parsedJson['UserId'],
      title: parsedJson['Tittle'],
      explanation: parsedJson['Explanation'],
      price: parsedJson['Price'],
      donationPrice: parsedJson['DonationPrice'],
      advertisementRate: parsedJson['AdvertisementRate'],
      advertisementSkills: parsedJson['AdvertisementSkills'],
      categoryIdGet: parsedJson['CatagoryId'],
    );
  }
}
class CategoryPostList {

  //Alınacak
  List<CategoryPost> list;
  

  //Basılacak
  final String pageId;
  final String categoryId;
  CategoryPostList({this.list,this.pageId,this.categoryId});
 
  factory CategoryPostList.fromJson(Map<String, dynamic> json) {
    var list = json['Data'] as List;
    print(list.runtimeType);
    List<CategoryPost> imagesList = list.map((i) => CategoryPost.fromJson(i)).toList();

    return CategoryPostList(
      list: imagesList,
    );
  }
 
  Map toMap() {
    var map = new Map<dynamic, dynamic>();
    map['PageId'] = pageId;
    map['category'] = categoryId;
    map['searchtip'] = '1';
    return map;
  }
}
Future categoryPost(Map _body) async {
  print("body : "+_body.toString());
  String url='https://willingly.tk/inc/php/Get_FreelanceAdvertisement.php';
  return http.post(url, headers:{'Content-Type':'application/x-www-form-urlencoded'},body:_body ).then((http.Response response) {

    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return CategoryPostList.fromJson(json.decode(response.body));
  });
}

Future<LoginJson> fetchUser() async {
  var response =
      await http.get('https://willingly.tk/inc/php/', headers:{'Content-Type':'application/x-www-form-urlencoded','SessionId':'${SessionId.id}'});
  if (response.statusCode == 200) {
    return LoginJson.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

Future<LoginJson> returnUser(mail,pass){
  return fetchPost(mail, pass).then((e){
    return e;
  });
}
class User {
  bool status;
  String session;

  User({this.status,this.session});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      status: json['Status'],
      session: json['SessionID'],
    );
  }
}