import '../config/palette.dart';
import 'package:flutter/material.dart';
import './login_screen.dart';

class NoLoginHomeScreen extends StatefulWidget {
  int floor;
  final waitings;
  NoLoginHomeScreen({super.key, required this.floor, required this.waitings});

  @override
  State<NoLoginHomeScreen> createState() => _NoLoginHomeScreenState();
}

class _NoLoginHomeScreenState extends State<NoLoginHomeScreen> {

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
          'Laundry_No_Login',
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
                    children: [
                      DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              '1층'
                              ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              '2층'
                              ),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text(
                              '3층'
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
                    ],
                  ),
                ),
                const Text(
                  '세탁기',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) {
                    return IconButton(
                      icon: Icon(Icons.local_laundry_service, size: 40),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                    );
                  }),
                ),
                const SizedBox(height: 30),
                const Text(
                  '건조기',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(2, (index) {
                    return IconButton(
                      icon: const Icon(Icons.dry_cleaning, size: 40),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  icon: const Icon(
                    Icons.people,
                    color: Palette.khsilver,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: (){
                  },
                  icon: const Icon(
                    Icons.local_laundry_service,
                    color: Palette.khsilver,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
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