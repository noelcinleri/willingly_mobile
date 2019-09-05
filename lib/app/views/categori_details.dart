import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:willingly/app/_routing/routes.dart';
import 'package:willingly/app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';
import 'package:willingly/json.dart';

class CategoryDetails extends StatefulWidget {
  final String categoryDetails;

  const CategoryDetails({Key key, this.categoryDetails}) : super(key: key);
  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final _formKey = GlobalKey<FormState>();
  String title;
  int id;
  @override
  void initState() { 
    title = widget.categoryDetails.split('##')[0];
    for (var i = 0; i < widget.categoryDetails.split('##').length; i++) {
      print('split$i => ${widget.categoryDetails.split('##')[i]}');
    }
    // id = int.parse(widget.categoryDetails.split('##')[1]);
    super.initState();
  }
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String mailErrorText;
  String passErrorText;
  @override
  Widget build(BuildContext context) {
    // Change Status Bar Color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor),
    );

  Widget appBar = Material(
      elevation: 5.0,
      shadowColor: Colors.grey,
      child: Container(
        padding: EdgeInsets.only(left: 1.0, right: 20.0, top: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
            Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 25.0,
          ),
        ),
            Text('       '),
          ],
        ),
      ),
    );
    
      return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 0.0, left: 0.0, right: 00.0),
          decoration: BoxDecoration(gradient: primaryGradient),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              appBar,
            ],
          ),
        ),
      ),
    );
    
    
  }
}
