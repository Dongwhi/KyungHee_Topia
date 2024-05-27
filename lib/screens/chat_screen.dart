import '../config/palette.dart';
import 'package:flutter/material.dart';
import './home_screen.dart';
import './friend_screen.dart';
import './addchat_screen.dart';
import './inchat_screen.dart';

class ChatScreen extends StatefulWidget {
  final reservated;
  const ChatScreen({super.key, required this.reservated});

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  final List<Map<String, String>> chats = [
    {'name': '3층', 'peoples': '52'},
    {'name': '302호', 'peoples': '3'},
    {'name': '동아리', 'peoples': '8'},
    // Add more friends here
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredChats = chats
        .where((chats) => chats['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
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
                          MaterialPageRoute(builder: (context) => AddChatScreen(reservated: widget.reservated)),
                        );
                      },
                    ),
                  ],
                ),
                ListView.builder(
                  itemCount: filteredChats.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InchatScreen(reservated: widget.reservated)));
                  },
                  icon: const Icon(
                    Icons.chat,
                    color: Palette.khsilver,
                    size: 40,
                  ),
                ),
                      title: Text(filteredChats[index]['name']!),
                    );
                  },
                  shrinkWrap: true,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FriendScreen(reservated: widget.reservated)));
                  },
                  icon: const Icon(
                    Icons.people,
                    color: Palette.khsilver,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(floor: 3, waitings: 2, reservated: widget.reservated)));
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
