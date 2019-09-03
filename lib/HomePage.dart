import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var connection = new PostgreSQLConnection("212.125.24.97", 5432, "Willingly", username: "WillinglyUser", password: "ok");
  //pgsql:host=212.125.24.97;port=5432;dbname=Willingly;user=WillinglyUser;password=ok
  @override
  void initState() {
    connection.open();
    super.initState();
  }
  Future<Widget> query()async{
    var results = await connection.query("SELECT a, b FROM table WHERE a = @aValue", substitutionValues: {
    "aValue" : 3
    });
    var a;
    var b;
    for (final row in results) {
      a = row[0];
      b = row[1];
    } 
    
    return Text('');
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      
    );
  }
}