import 'package:apptest/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:apptest/screens/friend_screen.dart';
import 'package:apptest/screens/home_screen.dart';
import 'package:apptest/screens/chat_screen.dart';
import 'package:apptest/screens/other_user_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

class ChattingScreen extends StatefulWidget {
  final username;
  final chatting_name;
  ChattingScreen({super.key, required this.chatting_name, required this.username});

  @override
  State<ChattingScreen> createState() => ChattingScreenState();
}

class ChattingScreenState extends State<ChattingScreen> {
  var box = Hive.box<User>('user_info1');
  var chatbox = Hive.box('chatting_info');
  final chatController = TextEditingController();

  User userdetect(String user_name) {
    return box.values.firstWhere((user) => user.name == user_name);
  }
  
  List<dynamic> chatusers = List.empty(growable : true);
  List<dynamic> chatcontents = List.empty(growable : true);

  @override
  Widget build(BuildContext context) {
    User user_now = userdetect(widget.username);
    String username_now = widget.username;
    //List<Map<dynamic, dynamic>> chatlog = chatbox.get(widget.chatting_name);
    List<dynamic> chatlog = chatbox.get(widget.chatting_name);
    chatlog.forEach((chat){
      chatusers.add(chat.keys);
      chatcontents.add(chat.values);
    });
    
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Palette.khsilver,
        ),
        backgroundColor: Palette.khblue,
        title: const Text(
          'Chatting',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 315,
            child: ListView.builder(
                  itemCount: chatcontents.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: IconButton(
                        onPressed: () {
                          String target_user = chatusers[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherUserScreen(target_user: target_user, username: widget.username,),
                            ),
                          );
                        },
                        icon: Icon(Icons.account_circle_outlined),
                      ),
                      title: Row(
                        children:
                        [
                          Text(chatusers[index].toString()),
                          Text(chatcontents[index].toString()),
                        ]
                      ),
                    );
                  },
                  shrinkWrap: true,
                ),
          ),
          

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     TextField(
          //       controller: chatController,
          //       //obscureText: true, // 입력한거 안보이게 하는 코드
          //     ),
          //     IconButton(
          //       onPressed: (){
          //         final chatting = chatController.text;
          //         List<dynamic> new_chatlog = chatlog;
          //         new_chatlog.add({username_now: chatting});
          //         chatbox.put(widget.chatting_name, new_chatlog);
          //         setState(() {
          //           chatbox = Hive.box('chatting_info');
          //         });
          //       },
          //       //icon: Icon(Icons.directions),
          //       icon: Icon(Icons.art_track),
          //     ),
          //   ],
          // ),
              TextField(
                controller: chatController,
                //obscureText: true, // 입력한거 안보이게 하는 코드
              ),
              IconButton(
                onPressed: (){
                  final chatting = chatController.text;
                  List<dynamic> new_chatlog = chatlog;
                  new_chatlog.add({username_now: chatting});
                  chatbox.put(widget.chatting_name, new_chatlog);
                  setState(() {
                    chatbox = Hive.box('chatting_info');
                    chatusers = List.empty(growable : true);
                    chatcontents = List.empty(growable : true);
                  });
                },
                //icon: Icon(Icons.directions),
                icon: Icon(Icons.art_track),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(username: widget.username)));
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
  
  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }
}