import 'package:apptest/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:apptest/screens/home_screen.dart';
import 'package:apptest/screens/chat_screen.dart';
import 'package:apptest/screens/other_user_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

class AddFriendScreen extends StatefulWidget {
  final username;
  AddFriendScreen({super.key, required this.username});

  @override
  State<AddFriendScreen> createState() => AddFriendScreenState();
}

class AddFriendScreenState extends State<AddFriendScreen> {
  final box = Hive.box<User>('user_info1');

  User userdetect(String user_name) {
    return box.values.firstWhere((user) => user.name == user_name);
  }
  
  // final List<Map<String, String>> all_friends = [
  //   {'name': 'Hong Gildong', 'profile': 'assets/alice.png'},
  //   {'name': 'Kim Yunghue', 'profile': 'assets/bob.png'},
  //   {'name': 'Lee Alpha', 'profile': 'assets/charlie.png'},
  //   // Add more friends here
  // ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final all_friends = box.keys.toList();
    List<dynamic> all_filteredFriends = all_friends
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
          'Add Friend',
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
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                if (searchQuery.isNotEmpty)
                SizedBox(
                  height: 315,
                  child: 
                  ListView.builder(
                    itemCount: all_filteredFriends.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: IconButton(
                          onPressed: () {
                            String target_user = all_filteredFriends[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtherUserScreen(target_user: target_user, username: widget.username,),
                              ),
                            );
                          },
                          icon: Icon(Icons.account_circle_outlined),
                        ),
                        title: Text(all_filteredFriends[index]!),
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