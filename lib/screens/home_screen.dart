import 'package:apptest/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:apptest/screens/friend_screen.dart';
import 'package:apptest/screens/chat_screen.dart';
import 'package:apptest/screens/profile_screen.dart';
import 'package:apptest/screens/reservation_screen.dart';

class HomeScreen extends StatefulWidget {
  int floor;
  final waitings;
  final reservated;
  HomeScreen({super.key, required this.floor, required this.waitings, required this.reservated});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
          'Laundry',
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 80,
                        height: 60,
                        child: DropdownButton(
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text(
                                '1층',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text(
                                '2층',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                                ),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text(
                                '3층',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                                ),
                            ),
                          ],
                          onChanged: (int? value){
                            setState(() {
                              widget.floor = value!;
                            });
                          },
                          value: widget.floor,
                        ),
                        ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.account_circle,
                          color: Palette.khblue,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.reservated)
                  Text(
                    '내 예약',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                if (widget.reservated)
                  SizedBox(height: 10),
                if (widget.reservated)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.local_laundry_service,
                        size: 40,
                      ),
                      Icon(
                        Icons.dry_cleaning,
                        size: 40,
                      ),
                    ],
                  ),
                Text(
                  '세탁기',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) {
                    return IconButton(
                      icon: Icon(Icons.local_laundry_service, size: 40),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReservationScreen(waitings: widget.waitings, reservated: widget.reservated),
                          ),
                        );
                      },
                    );
                  }),
                ),
                SizedBox(height: 30),
                Text(
                  '건조기',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(2, (index) {
                    return IconButton(
                      icon: Icon(Icons.dry_cleaning, size: 40),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReservationScreen(waitings: widget.waitings, reservated: widget.reservated),
                          ),
                        );
                      },
                    );
                  }),
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
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  icon: const Icon(
                    Icons.local_laundry_service,
                    color: Palette.khsilver,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(reservated: widget.reservated,)));
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
