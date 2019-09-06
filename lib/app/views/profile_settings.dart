import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:willingly/app/_routing/routes.dart';
import 'package:willingly/app/models/user.dart';
import 'package:willingly/app/models/user.dart' as us;
import 'package:willingly/app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';
import 'package:willingly/json.dart';
import 'package:line_icons/line_icons.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
  
}

final us.User user = users[0];

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  
  final _formKey = GlobalKey<FormState>();
  int _userPlatformRadioBtnVal = -1;

  void _handleUserPlatformChange(int value) {
    setState(() {
      _userPlatformRadioBtnVal = value;
    });
  }
  TextEditingController passController = TextEditingController();
  String passErrorText;
  TextEditingController mailController = TextEditingController();
  String mailErrorText;
  TextEditingController nameController = TextEditingController();
  String nameErrorText;
  TextEditingController surnameController = TextEditingController();
  String surnameErrorText;
  TextEditingController phoneController = TextEditingController();
  String phoneErrorText;


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
          "Ayarlar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 45.0,
          ),
        ),
      ],
    );

    //Check Information
    phoneCheck() {
      setState(() {
        if (phoneController.text.isEmpty) {
          phoneErrorText = "telefon numarası kısmını boş bırakamazsın";
        } else if (phoneController.text.length < 10) {
          phoneErrorText = "Geçerli bir telefon numarası giriniz";
        } else {
          try {
            if (phoneController.text.contains('+')) {
              phoneController.text.replaceAll('+', '');
            }
            int numara = int.parse(phoneController.text);
            phoneErrorText = null;
          } catch (e) {
            phoneErrorText = 'Geçerli bir telefon numarası giriniz';
          }
        }
      });
    }

    passCheck() {
      setState(() {
        if (passController.text.isEmpty) {
          passErrorText = "şifre kısmını boş bırakamazsın";
        } else if (passController.text.length <= 6) {
          passErrorText = "Şifreniz minimum 7 haneli olmalıdır";
        } else {
          try {
            num pass = int.parse(passController.text);
            passErrorText = 'Şifrenizde minimum 1 tane harf bulunmalıdır ';
          } catch (e) {
            passErrorText = null;
          }
        }
      });
    }

    mailCheck() {
      setState(() {
        if (mailController.text.isEmpty) {
          mailErrorText = "mail kısmını boş bırakamazsın";
        } else if (!mailController.text.contains('@') ||
            !mailController.text.contains('.')) {
          mailErrorText = 'Geçerli bir mail adresi giriniz';
        } else {
          mailErrorText = null;
        }
      });
    }

  surnameCheck() {
    setState(() {
      if (surnameController.text.isEmpty) {
        surnameErrorText = "Soyad kısmını boş bırakamazsınız";
      } else {
        surnameErrorText = null;
      }
    });
  }

  nameCheck() {
    setState(() {
      if (nameController.text.isEmpty) {
        nameErrorText = "Ad kısmını boş bırakamazsın";
      } else {
        nameErrorText = null;
      }
    });
  }

    final userImage = Container(
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(''),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );

    Widget emailField = TextFormField(
      controller: mailController,
      decoration: InputDecoration(
        errorText: mailErrorText,
        labelText: 'E-Posta Adresi',
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          LineIcons.envelope,
          color: Colors.white,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
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
          "Kullanıcı Ayarlar",
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

    Widget formFieldSpacing = SizedBox(
      height: 30.0,
    );

    Widget gender = Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Row(
        children: <Widget>[
          Radio(
            value: 0,
            groupValue: _userPlatformRadioBtnVal,
            onChanged: _handleUserPlatformChange,
          ),
          Text("Freelancer"),
          Radio(
            value: 1,
            groupValue: _userPlatformRadioBtnVal,
            onChanged: _handleUserPlatformChange,
          ),
          Text("Gönüllü"),
        ],
      ),
    );

    Widget registerForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildFormField('Adın', LineIcons.user, nameController,
                nameErrorText, nameCheck()),
            formFieldSpacing,
            _buildFormField('Soyadın', LineIcons.user, surnameController,
                surnameErrorText, () => surnameCheck()),
            formFieldSpacing,
            _buildFormField(
                'E-Posta Adresi',
                LineIcons.envelope,
                mailController,
                mailErrorText,
                () => mailCheck(),
                TextInputType.emailAddress),
            formFieldSpacing,
            //Telefon dogrulama
            // _buildFormField('Telefon Numarası', LineIcons.mobile_phone,phoneController,phoneErrorText,()=>phoneCheck(),TextInputType.phone),
            // formFieldSpacing,
            _buildFormField(
                'Parola', LineIcons.lock, passController, passErrorText, () {
              passCheck();
            }),
            formFieldSpacing,
          ],
        ),
      ),
    );
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                appBar,
                Container(
                  padding: EdgeInsets.only(top:25.0,left: 30.0, right: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(child: userImage,),
                      registerForm,
                      gender,
                    ],
                  ),
                ),
                Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {
                        print('Bilgilerine Düzenle Tuşuna Tıklandı');
                      },
                      color: Colors.red,
                      padding: EdgeInsets.all(4),
                      child: Text('Bilgilerini Düzenle',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
              ],
            ),
          ),
        ),      
    ); 
  }
  //Text Form Builder
  Widget _buildFormField(String label, IconData icon,
      TextEditingController _controller, String _errorText, Function complated,
      [TextInputType inputType = TextInputType.text]) {
    return TextField(
      onEditingComplete: complated,
      onChanged: (e) {
        complated();
      },
      controller: _controller,
      decoration: InputDecoration(
        errorText: _errorText,
        // errorStyle: TextStyle(color: Colors.white),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          icon,
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      keyboardType: inputType,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  }
}
