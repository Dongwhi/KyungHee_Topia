import '../config/palette.dart';
import 'package:flutter/material.dart';
import './home_screen.dart';
import './chat_screen.dart';
import './addfriend_screen.dart';

class FriendScreen extends StatefulWidget {
  final reservated;
  const FriendScreen({super.key, required this.reservated});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  
  final List<Map<String, String>> friends = [
    {'name': 'Alice', 'profile': 'assets/alice.png'},
    {'name': 'Bob', 'profile': 'assets/bob.png'},
    {'name': 'Charlie', 'profile': 'assets/charlie.png'},
    // Add more friends here
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredFriends = friends
        .where((friend) => friend['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
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
                          MaterialPageRoute(builder: (context) => AddFriendScreen(reservated: widget.reservated)),
                        );
                      },
                    ),
                  ],
                ),
                ListView.builder(
                  itemCount: filteredFriends.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.account_circle_outlined,
                      ),
                      title: Text(filteredFriends[index]['name']!),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(reservated: widget.reservated)));
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