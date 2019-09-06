import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:willingly/app/_routing/routes.dart';
import 'package:willingly/app/models/user.dart';
import 'package:willingly/app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:willingly/app/utils/sessionId.dart';
import 'package:willingly/app/utils/shared.dart';

class ProfilePage extends StatelessWidget {
  final User user = users[0];

  @override
  Widget build(BuildContext context) {
    final hr = Divider();
    final userStats = Positioned(
      bottom: 10.0,
      left: 40.0,
      right: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildUserStats('', ''),
          _buildUserStats('LIKED', ''),
          _buildUserStats('MATCHED', ''),
        ],
      ),
    );

    final userImage = Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(user.photo),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );

    final userNameLocation = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            user.name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            user.location,
            style: TextStyle(
              color: Colors.grey.withOpacity(0.6),
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    final userInfo = Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8.0),
            shadowColor: Colors.white,
            child: Container(
              height: 220.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    userImage,
                    SizedBox(width: 10.0),
                    userNameLocation
                  ],
                ),
              ),
            ),
          ),
        ),
        // userStats
      ],
    );

    final secondCard = Padding(
      padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 30.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Colors.white,
        child: Container(
          height: 344.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              _buildIconTile(LineIcons.user, Colors.red, 'Profilim',
                  () => { Navigator.pushNamed(context, userDetailsViewRoute),}),
              hr,
              _buildIconTile(LineIcons.edit, Colors.purpleAccent,
                  'Profil Ayarları', () => {Navigator.pushNamed(context, profilSettingRoute)}),
              hr,
              _buildIconTile(LineIcons.shopping_cart, Colors.green,
                  'Aldıklarım', () => {Navigator.pushNamed(context, orderPage)}),
              hr,
              _buildIconTile(LineIcons.question, Colors.blue, 'Destek', () {
                _launchURL();
              }),
              hr,
              _buildIconTile(LineIcons.gear, Colors.amber, 'Ayarlar', () => {Navigator.pushNamed(context, settingPage)}),
            ],
          ),
        ),
      ),
    );

    final thirdCard = Padding(
      padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Colors.white,
        child: Container(
          height: 128.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              _buildIconTile(
                  LineIcons.money, Colors.red, 'Satışlerim', () => {Navigator.pushNamed(context, salesPage)}),
              hr,
              _buildIconTile(
                  LineIcons.briefcase, Colors.blue, 'İş İlanlarım', () => {Navigator.pushNamed(context, jobAdsPage)}),
              // hr,
              // _buildIconTile(LineIcons.clock_o, Colors.orangeAccent,
              //     'Alıcı İstekleri', () => {})
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 350.0,
                      ),
                      Container(
                        height: 250.0,
                        decoration: BoxDecoration(gradient: primaryGradient),
                      ),
                      Positioned(top: 100, right: 0, left: 0, child: userInfo)
                    ],
                  ),
                  secondCard,
                  Container(padding: new EdgeInsets.all(20.0),child: Align(alignment: Alignment.topLeft, child: Text('Freelancer', style: TextStyle(fontSize: 18),),),),
                  thirdCard,
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {
                        SharedData.deleteData(SessionId.sharedId).then((e){
                          Navigator.of(context).pushNamedAndRemoveUntil(landingViewRoute,(Route<dynamic> route) => false);
                        });
                      },
                      color: Colors.red,
                      padding: EdgeInsets.all(4),
                      child: Text('ÇIKIŞ YAP',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStats(String name, String value) {
    return Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            color: Colors.grey.withOpacity(0.6),
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }

  Widget _buildIconTile(
      IconData icon, Color color, String title, Function ontap) {
    return GestureDetector(
      onTap: ontap,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
      ),
    );
  }

  _launchURL() async {
    const url = 'https://willingly.tk';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
