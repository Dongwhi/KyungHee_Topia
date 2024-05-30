import 'package:apptest/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:apptest/screens/home_screen.dart';
import 'package:apptest/screens/friend_screen.dart';
import 'package:apptest/screens/addchat_screen.dart';
import 'package:apptest/screens/chatting_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

class ChatScreen extends StatefulWidget {
  final username;
  ChatScreen({super.key, required this.username});

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final box = Hive.box<User>('user_info1');

  User userdetect(String user_name) {
    return box.values.firstWhere((user) => user.name == user_name);
  }

  // final List<Map<String, String>> chats = [
  //   {'name': '3층', 'peoples': '52'},
  //   {'name': '302호', 'peoples': '3'},
  //   {'name': '동아리', 'peoples': '8'},
  // ];


  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final List<String> chats = userdetect(widget.username).chatlist;
    List<String> filteredchats = chats
        .where((chats) => chats.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Palette.khsilver,
        ),
        backgroundColor: Palette.khblue,
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Palette.backgroundColor,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Icon(Icons.search),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_comment
                        ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddChatScreen(username: widget.username)),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 315,
                  child: 
                  ListView.builder(
                    itemCount: filteredchats.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: IconButton(
                          onPressed: (){
                            String target_chat = filteredchats[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChattingScreen(chatting_name: target_chat, username: widget.username,),
                              ),
                            );
                          },
                          icon: Icon(Icons.chat),
                          //icon: Image.asset('assets/icons/chat.jpg'),
                        ),
                        title: Text(filteredchats[index]),
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            color: Palette.khblue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FriendScreen(username: widget.username)));
                  },
                  icon: const Icon(
                    Icons.people,
                    color: Palette.khsilver,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(username: widget.username)));
                  },
                  icon: const Icon(
                    Icons.local_laundry_service,
                    color: Palette.khsilver,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                  },
                  icon: const Icon(
                    Icons.chat,
                    color: Palette.khsilver,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
