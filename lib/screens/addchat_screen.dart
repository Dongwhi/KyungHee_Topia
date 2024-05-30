import 'package:apptest/config/palette.dart';
import 'package:apptest/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:apptest/screens/home_screen.dart';
import 'package:apptest/screens/friend_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

class AddChatScreen extends StatefulWidget {
  final username;
  AddChatScreen({super.key, required this.username});

  @override
  State<AddChatScreen> createState() => AddChatScreenState();
}

class AddChatScreenState extends State<AddChatScreen> {
  final box = Hive.box<User>('user_info1');
  var chatbox = Hive.box('chatting_info');

  User userdetect(String user_name) {
    return box.values.firstWhere((user) => user.name == user_name);
  }

  //final List<String> friends = ['Alice', 'Bob', 'Charlie'];
  //final List<bool> isChecked = [false, false, false];

  final chatnameController = TextEditingController();
  final isChecked = List<bool>.filled(100, false);

  @override
  Widget build(BuildContext context) {
    User user_now = userdetect(widget.username);
    final List<String> friends = userdetect(widget.username).friends;
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Palette.khsilver,
        ),
        backgroundColor: Palette.khblue,
        title: const Text(
          'Add Chat',
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
                    Icon(Icons.chat_bubble_outline),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: chatnameController,
                        decoration: const InputDecoration(
                          hintText: 'Chat name...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 315,
                  child: 
                  ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: 
                    (context, index) {
                      return CheckboxListTile(
                        secondary: Icon(
                          Icons.account_circle_outlined,
                        ),
                        title: Text(friends[index]),
                        value: isChecked[index],
                        onChanged: (value){
                          setState(() {
                            isChecked[index] = value!;
                          });
                        },
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
                        child: const Text(
                          '만들기',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(	//모서리를 둥글게
                            borderRadius: BorderRadius.circular(3)
                          ),
                          backgroundColor: Palette.khblue,
                          fixedSize: Size(100, 40),
                        ),
            onPressed: () {
              String chatname = chatnameController.text;

              chatbox.put(chatname, [{widget.username:'Hello'}]);

              List<String> chatlist_now = user_now.chatlist;
              chatlist_now.add(chatname);
              user_now.chatlist = chatlist_now;
              box.put(widget.username, user_now);

              List<String> entry = friends
              .where((friend) => isChecked[friends.indexOf(friend)])
              .toList();
              entry.forEach((name){
                User tempouser = userdetect(name);
                List<String> tempochatlist = tempouser.chatlist;
                List<String> new_chatlist = tempochatlist;
                new_chatlist.add(chatname);
                tempouser.chatlist = new_chatlist;
                box.put(name, tempouser);
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(username: widget.username),
                ),
              );
            },
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

  @override
  void dispose() {
    chatnameController.dispose();
    super.dispose();
  }
}