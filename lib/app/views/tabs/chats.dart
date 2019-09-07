import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:willingly/app/models/chat.dart' as ch;
import 'package:willingly/app/utils/colors.dart';
import 'package:willingly/json.dart';


class ChatsPage extends StatefulWidget {
  ChatsPage({Key key}) : super(key: key);

  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  
  List chats;
  @override
  void initState() { 
    fetchChat().then((e){
      print('chatroom => ${e.chatRoom[0].toString()}');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    Widget pageTitle = Padding(
      padding: EdgeInsets.only(top: 1.0, bottom: 20.0),
      child: Text(
        "Chats",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 40.0,
        ),
      ),
    );

    Widget searchBar = Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      height: 50.0,
      width: deviceWidth,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.only(top: 15.0),
          hintText: 'Search...',
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );


    Widget chatList = Container(
      height: 500.0,
      // child: ListView(
      //   children: chats.map((chat) => _buildChatTile(chat, context)).toList(),
      // ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          width: deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pageTitle,
                    searchBar,
                    chatList
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  

  Widget _buildChatTile(ChatRoom chatRoom, BuildContext context) {
    final unreadCount = Positioned(
      bottom: 9.0,
      right: 0.0,
      child: Container(
        height: 25.0,
        width: 25.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.0),
          gradient: primaryGradient,
        ),
        child: Center(
          child: Text(
            chatRoom.unreadCount.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    final userImage = InkWell(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   userDetailsViewRoute,
        //   arguments: chat,
        // );
      },
      child: Stack(
        children: <Widget>[
          Hero(
            tag: 'bak',
            child: Container(
              margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(chatRoom.userImage),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          chatRoom.unreadCount == 0 ? Container() : unreadCount
        ],
      ),
    );

    final userNameMessage = Expanded(
      child: InkWell(
        onTap: () {
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: 'tag',
                child: Text(
                  chatRoom.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Text(
                chatRoom.message,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: Colors.grey.withOpacity(0.6),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: <Widget>[userImage, userNameMessage],
      ),
    );
  }
}
