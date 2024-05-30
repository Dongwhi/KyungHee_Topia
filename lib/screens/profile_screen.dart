import 'package:flutter/material.dart';
import 'package:apptest/config/palette.dart';
import 'package:apptest/screens/alarm_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:apptest/screens/login_screen.dart';
import '../users.dart';


class ProfileScreen extends StatefulWidget {
  final username;
  const ProfileScreen({super.key, required this.username,});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final box = Hive.box<User>('user_info1');
    
  User userdetect(String user_name) {
    return box.values.firstWhere((user) => user.name == user_name);
  }

  @override
  Widget build(BuildContext context) {
    User user_now = userdetect(widget.username);
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Palette.khsilver,
        ),
        backgroundColor: Palette.khblue,
        title: const Text(
          '프로필',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 160,
                  height: 200,
                  padding: EdgeInsets.all(16.0),
                  color: Colors.grey[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Palette.khblue,
                        size: 50,
                      ),
                      Text(
                        widget.username,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${user_now.floor.toString()} 층',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '1학년',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      '최근 이용 날짜: '
                    ),
                    Text(
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      '평균 이용 주기: '
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Text(
                  '시스템',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  child: Text(
                    style: TextStyle(
                      fontSize: 18,
                      color: Palette.khblue
                    ),
                    '알림 설정'
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AlarmScreen()));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Text(
                  '계정',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  '결제수단'
                ),
                Text(
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  '비밀번호 변경'
                ),
                TextButton(
                  child: Text(
                    style: TextStyle(
                      fontSize: 18,
                      color: Palette.khblue
                    ),
                    '로그아웃',
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
                Text(
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  '회원탈퇴'
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// class _ProfileScreenState extends State<ProfileScreen> {
//    @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: Palette.khsilver,
//         ),
//         backgroundColor: Palette.khblue,
//         title: const Text(
//           '프로필',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // Left Column
//             Column(
//               children: <Widget>[
//                 // Profile Box
//                 Container(
//                   padding: EdgeInsets.all(16.0),
//                   color: Colors.grey[850],
//                   child: Column(

//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // System Settings
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text('System', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     ListTile(
//                       title: Text('Notification Settings'),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => AlarmScreen()),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 // Account Settings
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text('Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     ListTile(
//                       title: Text('Payment Methods'),
//                       onTap: () {
//                         // Add your onTap code here
//                       },
//                     ),
//                     ListTile(
//                       title: Text('Change Password'),
//                       onTap: () {
//                         // Add your onTap code here
//                       },
//                     ),
//                     ListTile(
//                       title: Text('Logout'),
//                       onTap: () {
//                         // Add your onTap code here
//                       },
//                     ),
//                     ListTile(
//                       title: Text('Delete Account'),
//                       onTap: () {
//                         // Add your onTap code here
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(width: 20),
//             // Right Column
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     'Recent Usage Date: 2024-05-17',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Average Usage Interval: 5 days',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


