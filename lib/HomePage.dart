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
    super.initState();
  }
  Future<Widget> query()async{
    connection.open();
    var results = await connection.query("SELECT * FROM public.\"AA\" WHERE \"Id\" = '0'");
    
    return Text('$results',style:TextStyle(color:Colors.green));
  }
  @override
  Widget build(BuildContext context) {
    Text s ;
    query().then((e){
      s= e;
      });
    if(s == null){
      return Container(
        child: Text('Bekle Data Geliyor'),
      );
    }
    else{
      return Container(
        child: s,
      );
    }
  }
}