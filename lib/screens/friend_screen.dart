import '../config/palette.dart';
import 'package:flutter/material.dart';
import './home_screen.dart';
import './chat_screen.dart';
import './addfriend_screen.dart';
import 'package:apptest/screens/other_user_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

class FriendScreen extends StatefulWidget {
  final username;
  FriendScreen({super.key, required this.username});
  

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  final box = Hive.box<User>('user_info1');
  

  User userdetect(String user_name) {
    return box.values.firstWhere((user) => user.name == user_name);
  }

  // final List<Map<String, String>> friends = [
  //   {'name': 'Alice', 'profile': 'assets/alice.png'},
  //   {'name': 'Bob', 'profile': 'assets/bob.png'},
  //   {'name': 'Charlie', 'profile': 'assets/charlie.png'},
  //   // Add more friends here
  // ];

  

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final List<String> friends = userdetect(widget.username).friends;
    List<String> filteredFriends = friends
        .where((friend) => friend!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Palette.khsilver,
        ),
        backgroundColor: Palette.khblue,
        title: const Text(
          'Friend',
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
                        Icons.person_add_alt_1
                        ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddFriendScreen(username: widget.username)),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 315,
                  child: 
                  ListView.builder(
                    itemCount: filteredFriends.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: IconButton(
                          onPressed: () {
                            String target_user = filteredFriends[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtherUserScreen(target_user: target_user, username: widget.username,),
                              ),
                            );
                          },
                          icon: Icon(Icons.account_circle_outlined),
                        ),
                        title: Text(filteredFriends[index]!),
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
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => FriendScreen()));
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
}