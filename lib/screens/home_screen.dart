import 'package:apptest/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:apptest/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
  //   //MaterialPageRoute(builder: (context) => const LoginScreen());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Palette.khblue,
        title: const Text(
          'KyungHee Topia!!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Palette.backgroundColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80 - 60 - 51,
            //height: 100,
          ),
          Container(
            height: 60,
            color: Palette.khred,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  icon: const Icon(
                    Icons.people,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  icon: const Icon(
                    Icons.home,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  icon: const Icon(
                    Icons.chat,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
        
      // ),
    );
  }
}


// class HomeScreen extends StatefulWidget{
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   HomeScreenState createState() => HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>{
//   var isLogin = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Palette.khblue,
//       body: Stack(
//         children: [
//           Positioned(
//             bottom: 0,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 60,
//               color: Palette.khsilver,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     onPressed: (){
//                       // if(isLogin){
//                       //   Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(builder: (context) => const FriendScreen()),
//                       //   );
//                       // }
//                       if(!isLogin){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const LoginScreen()),
//                         );
//                       }
//                     },
//                     icon: const Icon(
//                       Icons.people
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: (){
//                       if(!isLogin){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const LoginScreen()),
//                         );
//                       }
//                     },
//                     icon: const Icon(
//                       Icons.home
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: (){
//                       // if(isLogin){
//                       //   Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(builder: (context) => const ChatScreen()),
//                       //   );
//                       // }
//                       if(!isLogin){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const LoginScreen()),
//                         );
//                       }
//                     },
//                     icon: const Icon(
//                       Icons.chat
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 20,
//             left: 20,
//             child: ListView(
//               scrollDirection: Axis.vertical,
//               children: const [
//                 Text(
//                   '1 층',
//                   style: TextStyle(
//                   letterSpacing: 1.0,
//                   color: Colors.black,
//                   ),
//                 ),
//                 Text(
//                   '2 층',
//                   style: TextStyle(
//                   letterSpacing: 1.0,
//                   color: Colors.black,
//                   ),
//                 ),
//                 Text(
//                   '3 층',
//                   style: TextStyle(
//                   letterSpacing: 1.0,
//                   color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),

//     );
//   }
// }