import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var connection = new PostgreSQLConnection("localhost", 5432, "dart_test", username: "dart", password: "ok");
  @override
  void initState() {
    connection.open();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}