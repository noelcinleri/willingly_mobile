import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:willingly/app/_routing/routes.dart';
import 'package:willingly/app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';
import 'package:willingly/json.dart';
import 'package:line_icons/line_icons.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final _formKey = GlobalKey<FormState>();

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
    Widget pageTitle = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Profil Ayarlar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 45.0,
          ),
        ),
      ],
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
          "Ayarlar",
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
    


    bool _notification = true;
    bool _sendfeedback = true;
      return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 0.0, left: 0.0, right: 00.0),
          decoration: BoxDecoration(gradient: primaryGradient),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              appBar,
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ListView(
                  shrinkWrap: true,
                  children: <Card>[
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications,size: 40,),
                        title: Text('Bildirimler'),
                        subtitle: Text('Uygulamayla ilgili son bilgileri alin'),
                        trailing: CupertinoSwitch(
                          value: _notification,
                          onChanged: (bool value) { setState(() { _notification = value; }); },
                          activeColor: Color(0xFFfbab66),
                        ),
                        onTap: () { setState(() { _notification = !_notification; }); },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.error_outline,size: 40,),
                        title: Text('Uygulama Hata Ayıklama'),
                        subtitle: Text('Hatamızı bize vererek bize yardım edin.'),
                        trailing: CupertinoSwitch(
                          value: _sendfeedback,
                          onChanged: (bool value) { setState(() { _sendfeedback = value; }); },
                          activeColor: Color(0xFFfbab66),
                        ),
                        onTap: () { setState(() { _sendfeedback = !_sendfeedback; }); },
                      ),
                    ),
                  ],
              ),
              )
            ],
          ),
        ),
      ),
    );
    
    
  }
}
