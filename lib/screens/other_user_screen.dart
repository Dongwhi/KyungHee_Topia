import 'package:apptest/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:apptest/screens/friend_screen.dart';
import 'package:apptest/screens/home_screen.dart';
import 'package:apptest/screens/chat_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

class OtherUserScreen extends StatefulWidget {
  final username;
  final target_user;
  OtherUserScreen({super.key, required this.target_user, required this.username});

  @override
  State<OtherUserScreen> createState() => OtherUserScreenState();
}

class OtherUserScreenState extends State<OtherUserScreen> {
  var box = Hive.box<User>('user_info1');

  User userdetect(String user_name) {
    return box.values.firstWhere((user) => user.name == user_name);
  }

  @override
  Widget build(BuildContext context) {
    User user_now = userdetect(widget.username);
    String username_now = widget.username;
    List<String> friends = user_now.friends;
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Palette.khsilver,
        ),
        backgroundColor: Palette.khblue,
        title: const Text(
          'User Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/icons/profile.jpg',
            height: 200,
            width: 200,
          ),
          Text(widget.target_user),
          

          if (friends.contains(widget.target_user))
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen(username: user_now.name))
                );
              },
              child: const Text(
                '1:1 대화',
                style: TextStyle(color: Palette.activeColor)
              ),
            ),
          if (!friends.contains(widget.target_user))
            ElevatedButton(
              onPressed: (){
                friends.add(widget.target_user);
                box.put(user_now.name, User(user_now.name, user_now.nickname, user_now.id, user_now.password, user_now.floor, user_now.nextlogin, user_now.reservated, user_now.warning, friends.toSet().toList(), user_now.chatlist));
                setState(){
                  box = Hive.box<User>('userinfo');
                };
              },
              child: const Text(
                '친구추가',
                style: TextStyle(color: Palette.activeColor)
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

// ElevatedButton addfriend_or_chat(BuildContext context, String target_user, User user_now){
//   var box = Hive.box<User>('userinfo');
//   List<String> friends = user_now.friends;
//   if (friends.contains(target_user)){
//     return ElevatedButton(
//       onPressed: (){
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ChatScreen(username: user_now.name))
//         );
//       },
//       child: Text(
//         '1:1 대화'
//       ),
//     );
//   } else{
//     return ElevatedButton(
//       onPressed: (){
//         friends.add(target_user);
//         box.put(user_now.name, User(user_now.name, user_now.nickname, user_now.id, user_now.password, user_now.floor, user_now.nextlogin, user_now.reservated, user_now.warning, friends));
//       },
//       child: Text(
//         '친구추가'
//       ),
//     );
//   }
// }