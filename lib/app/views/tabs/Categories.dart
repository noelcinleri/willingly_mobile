import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:willingly/app/utils/utils.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

  final hr = Divider();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right: 20.0,
        ),
        height: deviceHeight,
        width: deviceWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 70,
              child: searchField,
            ),
            _buildIconTile(Icons.gamepad, Colors.blue, 'Games'),hr,
            _buildIconTile(Icons.gamepad, Colors.blue, 'Games'),hr,
            _buildIconTile(Icons.gamepad, Colors.blue, 'Games'),hr,

          ],
        ),
      ),
    );
  }
  Widget _buildIconTile(IconData icon, Color color, String title) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
      leading: Container(
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      trailing: Icon(LineIcons.chevron_circle_right),
    );
  }
  

  Widget searchField = TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(Icons.search,color: Colors.black,),
          labelText: 'Ara',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green))),
  );
}
