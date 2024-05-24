import '../config/palette.dart';
import './chat_screen.dart';
import 'package:flutter/material.dart';
import './home_screen.dart';
import './friend_screen.dart';

class AddChatScreen extends StatefulWidget {
  final reservated;
  const AddChatScreen({super.key, required this.reservated});

  @override
  State<AddChatScreen> createState() => AddChatScreenState();
}

class AddChatScreenState extends State<AddChatScreen> {

  final List<String> friends = ['Alice', 'Bob', 'Charlie'];
  final List<bool> isChecked = [false, false, false];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
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
                const Row(
                  children: <Widget>[
                    Icon(Icons.chat_bubble_outline),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Chat name...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
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
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(reservated: widget.reservated),
                ),
              );
            },
            child: const Text('만들기'),
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