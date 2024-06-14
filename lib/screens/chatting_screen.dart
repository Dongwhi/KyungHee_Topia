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
  final scrollController = ScrollController();

  User userdetect(String user_name) {
    return box.values.firstWhere((user) => user.name == user_name);
  }
  
  List<dynamic> chatusers = List.empty(growable : true);
  List<dynamic> chatcontents = List.empty(growable : true);

  @override
  Widget build(BuildContext context) {
    User user_now = userdetect(widget.username);
    String username_now = widget.username;
    List<dynamic> chatlog = chatbox.get(widget.chatting_name);
    chatlog.forEach((chat){
      chatusers.add(chat.keys);
      chatcontents.add(chat.values);
    });
    var isNull = true;
    
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){
                  showPopup(context, '채팅 탈퇴', '이 채팅방에서 탈퇴하시겠습니까?', widget.username ,widget.chatting_name);
                },
                icon: Icon(Icons.directions),
              ),
            ],
          ),
          SizedBox(
            height: 315,
            child: ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: chatcontents.length,
                  itemBuilder: (context, index) {
                    if (chatusers[index].toString().substring(1, chatusers[index].toString().indexOf(')')) == widget.username) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(chatcontents[index].toString().substring(1, chatcontents[index].toString().indexOf(')')), style: TextStyle(fontSize: 16))
                              )
                            )
                          ]
                        ),
                      );
                    } else {
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
                          icon: const Icon(Icons.account_circle_outlined),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(chatusers[index].toString().substring(1, chatusers[index].toString().indexOf(')'))),
                            Card(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(chatcontents[index].toString().substring(1, chatcontents[index].toString().indexOf(')')), style: TextStyle(fontSize: 16))
                              )
                            )
                          ]
                        ),
                      );
                    }
                    
                  },
                  shrinkWrap: true,
                ),
          ),
              TextField(
                controller: chatController,
                onChanged: (String text) {
                  if (text.length > 0) {
                    isNull = false;
                  }
                },
                onSubmitted: (String text) {
                  if (!isNull) {
                    final chatting = chatController.text;
                    List<dynamic> new_chatlog = chatlog;
                    new_chatlog.insert(0, {username_now: chatting});
                    scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    chatbox.put(widget.chatting_name, new_chatlog);
                    setState(() {
                      chatbox = Hive.box('chatting_info');
                      chatusers = List.empty(growable : true);
                      chatcontents = List.empty(growable : true);
                    });
                    chatController.clear();
                  }
                },
              ),
              IconButton(
                onPressed: (){
                  if (!isNull) {
                    final chatting = chatController.text;
                    List<dynamic> new_chatlog = chatlog;
                    new_chatlog.insert(0, {username_now: chatting});
                    scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    chatbox.put(widget.chatting_name, new_chatlog);
                    setState(() {
                      chatbox = Hive.box('chatting_info');
                      chatusers = List.empty(growable : true);
                      chatcontents = List.empty(growable : true);
                    });
                    chatController.clear();
                  }
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
  
void _handleSubmitted(String text) {
  // chatController.clear();
  // final chatting = chatController.text;
  // List<dynamic> new_chatlog = chatlog;
  // new_chatlog.insert(0, {username_now: chatting});
  // scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  // chatbox.put(widget.chatting_name, new_chatlog);
  // setState(() {
  //   chatbox = Hive.box('chatting_info');
  //   chatusers = List.empty(growable : true);
  //   chatcontents = List.empty(growable : true);
  // });
}

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }
}

void showPopup(BuildContext context, String title, String message, String username, String chatname) { // 팝업 함수
  var box = Hive.box<User>('user_info1');
  User user_now = box.values.firstWhere((user) => user.name == username);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              List<String> new_chatlist = user_now.chatlist;
              new_chatlist.remove(chatname);
              box.put(username, User(username, user_now.nickname, user_now.id, user_now.password, user_now.floor, user_now.nextlogin, user_now.reservated, user_now.warning, user_now.friends, new_chatlist));
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(username: username)));
            },
          ),
        ],
      );
    },
  );
}