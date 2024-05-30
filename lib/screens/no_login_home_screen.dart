import 'package:apptest/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:apptest/screens/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

class NoLoginHomeScreen extends StatefulWidget {
  NoLoginHomeScreen({super.key});

  @override
  State<NoLoginHomeScreen> createState() => _NoLoginHomeScreenState();
}

class _NoLoginHomeScreenState extends State<NoLoginHomeScreen> {
  final boxwaiting = Hive.box('waiting_info');
  int floor = 1;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold 위젯으로 모두 감쌈
      backgroundColor: Palette.backgroundColor, // Scaffold 위젯의 배경 색 설정
      appBar: AppBar( // Scaffold 위젯은 appBar을 가질 수 있음. appBar로 AppBar 위젯 사용
        iconTheme: const IconThemeData( // AppBar 위젯의 테마(화살표 색) 설정
          color: Palette.khsilver, // khsilver색 사용
        ),
        backgroundColor: Palette.khblue, // AppBar 위젯의 배경 색 설정
        title: const Text( // AppBar 위젯 안에 들어갈 title 설정
          'Laundry', // Laundry가 나오게 함
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
              children: [ // Column 위젯의 children 안에 Column에 들어갈 위젯들을 담으면 됨.
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
                              builder: (context) => LoginScreen(), // ProfileScreen으로 이동함.
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
                Text( // 세탁기 텍스트 띄우기.
                  '세탁기',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row( // 세탁기 아이콘들 띄우기.
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Stack( // 첫 번째 세탁기
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            child: Image.asset(
                              "assets/icons/machine.jpg",
                              width:50,
                              height:50,
                              ),
                          ),
                          onTap: () {
                            showPopup(context, '알림', '해당 세탁기는 예약 불가능한 세탁기입니다.');
                          },
                        ),
                        Text(boxwaiting.get(floor)[0].toString())
                      ],
                    ),
                    display_machine(context, 1, floor), // 두 번째 세탁기
                    display_machine(context, 2, floor), // 세 번째 세탁기
                  ],
                ),
                SizedBox(height: 30), // 빈 공간 만들기.
                Text( // 건조기 텍스트 띄우기.
                  '건조기',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row( // 건조기 아이콘들 띄우기.
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            showPopup(context, '알림', '해당 건조기는 예약 불가능한 세탁기입니다.');
                          },
                          child: Image.asset(
                            "assets/icons/machine.jpg",
                            width:50,
                            height:50,
                            ),
                          ),
                        Text(boxwaiting.get(floor)[3].toString())
                      ],
                    ),
                    display_machine(context, 4, floor), // 다섯 번째 건조기
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())); // FriendScreen로 이동.
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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

Stack display_machine(BuildContext context, int machine_index, int floor_now){
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
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Image.asset(
                            image_location,
                            width:50,
                            height:50,
                            ),
                          ),
                        Text(boxwaiting.get(floor_now)[machine_index].toString())
                      ],
                    );
}
