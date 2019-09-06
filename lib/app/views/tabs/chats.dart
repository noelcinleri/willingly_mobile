import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:willingly/app/_routing/routes.dart';
import 'package:willingly/app/models/chat.dart';
import 'package:willingly/app/models/user.dart';
import 'package:willingly/app/utils/colors.dart';
import 'package:willingly/app/utils/utils.dart';

class ChatsPage extends StatefulWidget {
  ChatsPage({Key key}) : super(key: key);

  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    Widget pageTitle = Padding(
      padding: EdgeInsets.only(top: 1.0, bottom: 20.0),
      child: Text(
        "Mesajlar",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 40.0,
        ),
      ),
    );

    Widget noConversationImage = Image.asset(
      AvailableImages.emptyState['assetPath'],
    );

    Widget noConversationHeader = Container(
      padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
      child: Text(
        "Burası bayağı yanlız",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
      ),
    );
    Widget noConversationText = Text(
      "Şu anda okunacak bir mesajın yok.",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.grey.withOpacity(0.6),
      ),
      textAlign: TextAlign.center,
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
          hintText: 'Ara...',
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
    );

    // final onlineUsersHeading = Text(
    //   "AKTİF KULLANICILAR",
    //   style: TextStyle(
    //     color: Colors.grey.withOpacity(0.6),
    //     fontWeight: FontWeight.w600,
    //     fontSize: 20.0,
    //   ),
    // );

    // final listOfOnlineUsers = Container(
    //   height: 100.0,
    //   child: ListView(
    //     scrollDirection: Axis.horizontal,
    //     children: users.map((user) => _buildUserCard(user, context)).toList(),
    //   ),
    // );

    // final onlineUsers = Container(
    //   margin: EdgeInsets.only(top: 20.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       onlineUsersHeading,
    //       SizedBox(
    //         height: 10.0,
    //       ),
    //       listOfOnlineUsers
    //     ],
    //   ),
    // );

    Widget chatList = Container(
      height: 500.0,
      child: ListView(
        children: chats.map((chat) => _buildChatTile(chat, context)).toList(),
      ),
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
                    //searchBar,
                    // onlineUsers,
                    //chatList,
                    noConversationImage,
                    noConversationHeader,
                    noConversationText,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  

  Widget _buildUserCard(User user, BuildContext context) {
    final firstName = user.name.split(" ")[0];

    Widget onlineTag = Positioned(
      bottom: 10.0,
      right: 3.0,
      child: Container(
        height: 15.0,
        width: 15.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.0),
          color: Colors.lightGreen,
        ),
      ),
    );
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => Navigator.pushNamed(context, chatDetailsViewRoute, arguments: user.id),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8.0),
                height: 70.0,
                width: 70.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(user.photo),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              onlineTag
            ],
          ),
        ),
        Text(
          firstName,
          style: TextStyle(fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget _buildChatTile(Chat chat, BuildContext context) {
    Widget unreadCount = Positioned(
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
            chat.unreadCount.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    Widget userImage = InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          userDetailsViewRoute,
          arguments: chat.userId,
        );
      },
      child: Stack(
        children: <Widget>[
          Hero(
            tag: chat.userImage,
            child: Container(
              margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(chat.userImage),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          chat.unreadCount == 0 ? Container() : unreadCount
        ],
      ),
    );

    Widget userNameMessage = Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            chatDetailsViewRoute,
            arguments: chat.userId,
          );
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: chat.userName,
                child: Text(
                  chat.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Text(
                chat.message,
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
