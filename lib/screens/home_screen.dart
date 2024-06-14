import 'package:apptest/config/palette.dart'; // 사용할 색 저장해놓은 파일.
import 'package:flutter/material.dart'; // material 스타일 위젯들을 사용하기 위해 import해야하는 것.
import 'package:apptest/screens/friend_screen.dart'; // 이동하게될 수 있는 페이지들
import 'package:apptest/screens/chat_screen.dart'; // 이동하게될 수 있는 페이지들
import 'package:apptest/screens/profile_screen.dart'; // 이동하게될 수 있는 페이지들
import 'package:apptest/screens/reservation_screen.dart'; // 이동하게될 수 있는 페이지들
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

// 세탁기 현황 페이지

class HomeScreen extends StatefulWidget { // StatefulWidget: 실시간으로 바뀔 수 있는 위젯.
  // int floor; // 정수형 변수 floor을 받기 위해 선언
  // final waitings; // 상수 waitings를 받기 위해 선언
  // final reservated; // 상수 reservated를 받기 위해 선언
  // HomeScreen({super.key, required this.floor, required this.waitings, required this.reservated}); // HomeScreen 위젯이 실행될 때 받는 변수들 지정. required는 꼭 넘겨받아야 함.
  final username;
  HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // HomeScreen의 State들 실행
}

class _HomeScreenState extends State<HomeScreen> {
  final box = Hive.box<User>('user_info1');
  final boxwaiting = Hive.box('waiting_info');
  int floor = 1;
  User userdetect(String user_name) {
    return box.values.firstWhere((user) => user.name == user_name);
  }
  bool getreservated(User user) {
    int res = user.reservated[0];
    if (res==0) {
      return false;
    }
    else {
      return true;
    }
  }
  int getfloor(User user) {
    return user.floor;
  }
  
  

  @override
  Widget build(BuildContext context) {
    User user_now = userdetect(widget.username);
    String username_now = widget.username;
    bool reservated = getreservated(user_now);
    return Scaffold( // Scaffold 위젯으로 모두 감쌈
      backgroundColor: Palette.backgroundColor, // Scaffold 위젯의 배경 색 설정
      appBar: AppBar( // Scaffold 위젯은 appBar을 가질 수 있음. appBar로 AppBar 위젯 사용
        iconTheme: const IconThemeData( // AppBar 위젯의 테마(화살표 색) 설정
          color: Palette.khsilver, // khsilver색 사용
        ),
        backgroundColor: Palette.khblue, // AppBar 위젯의 배경 색 설정
        title: const Text( // AppBar 위젯 안에 들어갈 title 설정
          '세탁기 현황', // Laundry가 나오게 함
          style: TextStyle( // title 텍스트 스타일 설정
            color: Colors.white, // 텍스트 색 하얀색으로 설정
            fontWeight: FontWeight.bold, // 볼드체로 설정
          ),
        ),
      ),
      body: Column( // Scaffold의 body 속성. Column 위젯으로 설정.
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Column 위젯은 안에 여러 위젯이 세로로 나열됨. 이 나열 방법을 설정.
        children: [ // Column 위젯의 children 안에 Column에 들어갈 위젯들을 담으면 됨.
          Container( // Column 안에 들어갈 첫 위젯을 Container(직사각형 위젯)로 설정. 여기에 들어간 것은 층 선택, 프로필, 내 예약, 세탁기, 건조기임
            color: Palette.backgroundColor, // Contrainer 위젯의 색을 설정.
            child: Column( // Container 안에 들어갈 위젯을 설정. 여기서는 Container 안에 Column을 넣음.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ // Column 위젯의 children 안에 Column에 들어갈 위젯들을 담으면 됨.
                SizedBox(
                  height: 30,
                ),
                Container( // Column 안에 들어갈 첫 위젯을 Container(직사각형 위젯)로 설정.
                  child: Row( // Container 안에 Row 위젯을 넣음. Row 위젯은 안에 여러 위젯이 가로로 나열됨. 여기엔 층 선택, 프로필 두 개가 들어감.
                    mainAxisAlignment: MainAxisAlignment.spaceAround, // 나열 방법 설정.
                    children: [ // Row에 들어갈 위젯들.
                      Container( // 첫 번째 위젯을 Container로 설정.
                        width: 80, // Container 너비 설정.
                        height: 60, // Container 높이 설정.
                        child: DropdownButton( // Contrainer 안에 들어갈 위젯을 DropdownButton으로 설정.(층 선택용)
                          isExpanded: true,
                          items: const [ // DropdownButton 안에 들어갈 위젯들 설정.
                            DropdownMenuItem( // DropdownMenuItem을 하나씩 설정해줌.
                              value: 1, // 아이템의 value 설정.
                              child: Text( // 아이템이 화면에 띄울 텍스트 설정.
                                '1층',
                                style: TextStyle( // 텍스트 스타일 설정.
                                  fontSize: 30, // 텍스트 크기 설정.
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
                          onChanged: (int? value){ // DropdownButton에서 value가 바뀌면 floor 변수를 value로 바꿈.
                            setState(() {
                              floor = value!;
                            });
                          },
                          value: floor, // DropdownButton가 표시하는 현재 선택된 value를 바뀐 value로 만들어줌.
                        ),
                        ),
                      IconButton( // 층 선택 옆에 표시할 프로필 아이콘, Row에 들어갈 두 번째 위젯.
                        onPressed: () { // 눌렀을 때의 동작 정의.
                          Navigator.push( // 다른 화면으로 이동하기.
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(username: widget.username), // ProfileScreen으로 이동함.
                            ),
                          );
                        },
                        icon: Icon( // IconButton 위젯의 아이콘을 설정.
                          Icons.account_circle,
                          color: Palette.khblue,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 5,
                    color: Colors.grey,
                    ),
                  ],
                ),
                
                if (reservated) // 만약 예약을 한 상태라면 아래의 Text 위젯을 띄움.
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '내 예약',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                if (reservated)
                  SizedBox(height: 10), // SizedBox 위젯은 공간을 남겨두기 위한 빈 박스임.
                if (reservated) // 예약 한 상태일 때 뜨는 세탁기와 건조기 아이콘들을 Row로 묶었음.
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '세탁기:',
                            style: TextStyle(fontSize: 20,),
                          ),
                          SizedBox(
                            width: 130,
                          ),
                          Text(
                            '건조기:',
                            style: TextStyle(fontSize: 20,),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '${user_now.reservated[1]} 층 ${user_now.reservated[2]} 번',
                            style: TextStyle(fontSize: 20,),
                          ),
                          SizedBox(
                            width: 115,
                          ),
                          Text(
                            '${user_now.reservated[3]} 층 ${user_now.reservated[4]} 번',
                            style: TextStyle(fontSize: 20,),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          reservated_display_machine(context, user_now.reservated[2]-1, user_now.reservated[1], username_now), // 예약한 세탁기
                          SizedBox(
                            width: 100,
                          ),
                          reservated_display_machine(context, user_now.reservated[4]-1, user_now.reservated[3], username_now), // 예약한 건조기
                        ],
                      ),
                      
                    ],
                  ),
                if (reservated)
                  SizedBox(
                    height: 10,
                  ),
                if (reservated)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 5,
                      color: Colors.grey,
                      ),
                    ],
                  ),
                
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text( // 세탁기 텍스트 띄우기.
                      '세탁기',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                
                SizedBox(
                  height: 20,
                ),
                Row( // 세탁기 아이콘들 띄우기.
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: 
                  // List.generate(3, (index) {
                  //   return IconButton(
                  //     icon: Icon(Icons.local_laundry_service, size: 40),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => ReservationScreen(waitings: widget.waitings, reservated: widget.reservated),
                  //         ),
                  //       );
                  //     },
                  //   );
                  // }),
                  [
                    SizedBox(
                      width: 30,
                    ),
                    Stack( // 첫 번째 세탁기
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            child: Image.asset(
                              "assets/icons/machine.jpg",
                              width:100,
                              height:100,
                              ),
                          ),
                          onTap: () {
                            showPopup(context, '알림', '해당 세탁기는 예약 없이 사용하는 공용 세탁기입니다.');
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '1',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20,),
                            (boxwaiting.get(floor)[0] >= 60 )? Text((boxwaiting.get(floor)[0] ~/ 60).toString() + "h " + (boxwaiting.get(floor)[0] % 60).toString() + "m") : Text(boxwaiting.get(floor)[0].toString() + "m"),
                            SizedBox(height: 40,),
                          ],
                        ),
                        
                      ],
                    ),
                    display_machine(context, 1, floor, username_now), // 두 번째 세탁기
                    display_machine(context, 2, floor, username_now), // 세 번째 세탁기
                  ],
                ),
                SizedBox(height: 30), // 빈 공간 만들기.
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text( // 건조기 텍스트 띄우기.
                      '건조기',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                
                SizedBox(
                  height: 20,
                ),
                Row( // 건조기 아이콘들 띄우기.
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: 
                  // List.generate(2, (index) {
                  //   return IconButton(
                  //     icon: Icon(Icons.dry_cleaning, size: 40),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => ReservationScreen(waitings: widget.waitings, reservated: widget.reservated),
                  //         ),
                  //       );
                  //     },
                  //   );
                  // }),
                  [
                    SizedBox(
                      width: 30,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            showPopup(context, '알림', '해당 건조기는 예약 없이 사용하는 공용 건조기입니다.');
                          },
                          child: Image.asset(
                            "assets/icons/machine.jpg",
                            width:100,
                            height:100,
                            ),
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '4',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20,),
                            (boxwaiting.get(floor)[3] >= 60 )? Text((boxwaiting.get(floor)[3] ~/ 60).toString() + "h " + (boxwaiting.get(floor)[3] % 60).toString() + "m") : Text(boxwaiting.get(floor)[3].toString() + "m"),
                            SizedBox(height: 40,),
                          ],
                        ),
                        
                      ],
                    ),
                    display_machine(context, 4, floor, username_now), // 다섯 번째 건조기
                  ],
                ),
              ],
            ),
          ),
          Container( // 하단 네비게이션 바 담을 Container 위젯.
            height: 60, // Container 높이 설정.
            color: Palette.khblue, // Contrainer 색 설정.
            child: Row( // Contrainer 안에 담을 위젯 설정. 여기선 Row 위젯을 넣었음.
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Row 위젯 내에서의 나열 방법 설정.
              children: [ // Row 위젯 안에 들어갈 위젯들 설정.
                IconButton( // 친구 화면용 아이콘.
                  onPressed: (){ // 눌렸을 때의 동작 정의.
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FriendScreen(username: widget.username))); // FriendScreen로 이동.
                  },
                  icon: const Icon(
                    Icons.people,
                    color: Palette.khsilver,
                    size: 40,
                  ),
                ),
                IconButton( // 홈 화면용 아이콘.
                  onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  icon: const Icon(
                    Icons.local_laundry_service,
                    color: Palette.khsilver,
                    size: 40,
                  ),
                ),
                IconButton( // 채팅 화면용 아이콘
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

void showPopup(BuildContext context, String title, String message) { // 팝업 함수
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// void showCanclePopup(BuildContext context, String title, String message, int floor, int machineindex, String username) { // 예약 취소 팝업 함수
//   var box = Hive.box<User>('user_info1');
//   var boxwaiting = Hive.box('waiting_info');
//   User user_now = box.get(username);
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: <Widget>[
//           TextButton(
//             child: Text("OK"),
//             onPressed: () {
//               if (machineindex == 1 || machineindex == 2){
//                 box.put(username, User(username, user_now.nickname, user_now.id, user_now.password, user_now.floor, user_now.nextlogin, newreservation, user_now.warning, user_now.friends, user_now.chatlist));
//               } else{

//               }
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: Text("NO"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

Stack display_machine(BuildContext context, int machine_index, int floor_now, String username_now){
  final boxwaiting = Hive.box('waiting_info');
  int time = boxwaiting.get(floor_now)[machine_index];
  String image_location = 'assets/icons/machine.jpg';
  if (time>=100){
    image_location = 'assets/icons/machine_red.jpg';
  } else if (time >= 50){
    image_location = 'assets/icons/machine_orenge.jpg';
  } else{
    image_location = 'assets/icons/machine_green.jpg';
  }
  return Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReservationScreen(username: username_now, machinenum: machine_index+1, floor: floor_now,),
                              ),
                            );
                          },
                          child: Image.asset(
                            image_location,
                            width:100,
                            height:100,
                            ),
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${machine_index+1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20,),
                            (boxwaiting.get(floor_now)[machine_index] >= 60 )? Text((boxwaiting.get(floor_now)[machine_index] ~/ 60).toString() + "h " + (boxwaiting.get(floor_now)[machine_index] % 60).toString() + "m") : Text(boxwaiting.get(floor_now)[machine_index].toString() + "m"),
                            SizedBox(height: 40,),
                          ],
                        ),
                        
                      ],
                    );
}

Stack reservated_display_machine(BuildContext context, int machine_index, int floor_reserve, String username_now){
  final boxwaiting = Hive.box('waiting_info');
  if (floor_reserve==0){
    return Stack(
      children: [
        Image.asset(
          'assets/icons/machine.jpg',
          width:100,
          height:100,
        ),
      ],
    );
  } else{
    int time = boxwaiting.get(floor_reserve)[machine_index] - 50;
    if (time<0){
      time = 0;
    }
    String image_location = 'assets/icons/machine.jpg';
    if (time>=100){
      image_location = 'assets/icons/machine_red.jpg';
    } else if (time >= 50){
      image_location = 'assets/icons/machine_orenge.jpg';
    } else{
      image_location = 'assets/icons/machine_green.jpg';
    }
    return Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              //showCanclePopup(context, '예약취소', '예약을 취소하시겠습니까?', floor_reserve, machine_index, username_now);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReservationScreen(username: username_now, machinenum: machine_index+1, floor: floor_reserve,),
                                ),
                              );
                            },
                            child: Image.asset(
                              image_location,
                              width:100,
                              height:100,
                              ),
                            ),
                          (time >= 60 )? Text((time ~/ 60).toString() + "h " + (time % 60).toString() + "m") : Text(time.toString() + "m")
                        ],
                      );
  }
}