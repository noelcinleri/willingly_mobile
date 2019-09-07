import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:willingly/app/_routing/routes.dart';
import 'package:willingly/app/models/message.dart';
import 'package:willingly/app/models/user.dart';
import 'package:willingly/app/utils/arguments.dart';
import 'package:willingly/app/widgets/chat_bubble.dart';
import 'package:willingly/json.dart';

class ChatDetailsPage extends StatefulWidget {

  _ChatDetailsPageState createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  
  List<Messages> messages = List();
  @override
  Widget build(BuildContext context) {
    messages = ChatDetailArguments.messages;
    print('messages lenght=> ${messages.length}');
    print('messages => $messages');
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    Widget userImage = InkWell(
      onTap: () => Navigator.pushNamed(context, userDetailsViewRoute),
      child: Hero(
        tag: '',
        child: Container(
          margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/blank-profile-picture.png'),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );

    Widget userName = Hero(
      tag: 'user.name',
      child: Text(
        ChatDetailArguments.chatRoom.userName,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    Widget appBar = Material(
      elevation: 5.0,
      shadowColor: Colors.grey,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
            userName,
            userImage
          ],
        ),
      ),
    );

    Widget textInput = Container(
      padding: EdgeInsets.only(left: 10.0),
      height: 47.0,
      width: deviceWidth * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Bir mesaj yaz...',
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    Widget messageList = ListView.builder(
      shrinkWrap:true,
      scrollDirection: Axis.vertical,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatBubble(
          message: messages[index],
          reciverId: ChatDetailArguments.chatRoom.reciverId,
        );
      },
    );

    Widget inputBox = Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 60.0,
        width: deviceHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.camera_alt,
                color: Colors.grey,
              ),
              iconSize: 32.0,
            ),
            textInput,
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Colors.grey,
              ),
              iconSize: 32.0,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: deviceHeight,
            width: deviceWidth,
            child: Column(
              children: <Widget>[
                appBar,
                SizedBox(
                  height: 10.0,
                ),
                messageList
              ],
            ),
          ),
          inputBox
        ],
      ),
    );
  }
}
