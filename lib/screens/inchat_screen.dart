import 'package:flutter/material.dart';

import '../config/palette.dart';
import './home_screen.dart';
import './friend_screen.dart';
import './chat_screen.dart';

class ChatInfo {
  String user;
  int time;
  String contents;

  ChatInfo(this.user, this.time, this.contents);
}


class InchatScreen extends StatefulWidget {
  final dynamic reservated;
  const InchatScreen({super.key, required this.reservated});

  @override
  State<InchatScreen> createState() => InchatScreenState();
}

class InchatScreenState extends State<InchatScreen> {
  final scrollController = ScrollController();
  final controller = TextEditingController();
  final List<ChatInfo> chatList = <ChatInfo>[];

  @override
  Widget build(BuildContext context){

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Palette.khsilver,
        ),
        backgroundColor: Palette.khblue,
        title: const Text(
          'Input chat room\'s name here',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.separated(
                shrinkWrap: true,
                reverse: true,
                controller: scrollController,
                itemCount: chatList.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    height: 80,
                    color: Palette.khsilver,
                    child:Center(
                      child:Text(chatList[index].contents)
                    )
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              )
            )
          )
        ),
        TextField()
        ],
      )
    );
  }
}