import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class FeedsPage extends StatefulWidget {
  FeedsPage({Key key}) : super(key: key);

  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  @override
  Widget build(BuildContext context) {

    //Gonullukler buraya gelecek
    Widget bottomCards = Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: ListView(
        shrinkWrap: true,
        children: <Card>[
          Card(
            child: Column(children: <Widget>[
              ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text('Two-line ListTile'),
              subtitle: Text('Here is a second line'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width-60,
                  lineHeight: 15.0,
                  percent: 0.5,
                  center: Text(
                    "50.0%",
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  trailing: Icon(Icons.mood),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
            ],)
          ),
        ],
      ),
    );

    Widget topCards = Container(
      child: new Swiper(
        itemBuilder: (BuildContext context,int index){
          return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );

    Widget pageTitle = Padding(
      padding: EdgeInsets.only(top: 1.0, bottom: 30.0),
      child: Text(
        "İhtiyaçlar",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 40.0,
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.withOpacity(0.1),
          padding: EdgeInsets.only(top: 40.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pageTitle,
                    bottomCards,
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
