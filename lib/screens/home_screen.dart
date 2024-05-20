import 'package:apptest/config/palette.dart'; // 사용할 색 저장해놓은 파일.
import 'package:flutter/material.dart'; // material 스타일 위젯들을 사용하기 위해 import해야하는 것.
import 'package:apptest/screens/friend_screen.dart'; // 이동하게될 수 있는 페이지들
import 'package:apptest/screens/chat_screen.dart'; // 이동하게될 수 있는 페이지들
import 'package:apptest/screens/profile_screen.dart'; // 이동하게될 수 있는 페이지들
import 'package:apptest/screens/reservation_screen.dart'; // 이동하게될 수 있는 페이지들

// 세탁기 현황 페이지

class HomeScreen extends StatefulWidget { // StatefulWidget: 실시간으로 바뀔 수 있는 위젯.
  int floor; // 정수형 변수 floor을 받기 위해 선언
  final waitings; // 상수 waitings를 받기 위해 선언
  final reservated; // 상수 reservated를 받기 위해 선언
  HomeScreen({super.key, required this.floor, required this.waitings, required this.reservated}); // HomeScreen 위젯이 실행될 때 받는 변수들 지정. required는 꼭 넘겨받아야 함.

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // HomeScreen의 State들 실행
}

class _HomeScreenState extends State<HomeScreen> {

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
                              widget.floor = value!;
                            });
                          },
                          value: widget.floor, // DropdownButton가 표시하는 현재 선택된 value를 바뀐 value로 만들어줌.
                        ),
                        ),
                      IconButton( // 층 선택 옆에 표시할 프로필 아이콘, Row에 들어갈 두 번째 위젯.
                        onPressed: () { // 눌렀을 때의 동작 정의.
                          Navigator.push( // 다른 화면으로 이동하기.
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(), // ProfileScreen으로 이동함.
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
                if (widget.reservated) // 만약 예약을 한 상태라면 아래의 Text 위젯을 띄움.
                  Text(
                    '내 예약',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                if (widget.reservated)
                  SizedBox(height: 10), // SizedBox 위젯은 공간을 남겨두기 위한 빈 박스임.
                if (widget.reservated) // 예약 한 상태일 때 뜨는 세탁기와 건조기 아이콘들을 Row로 묶었음.
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
                Text( // 세탁기 텍스트 띄우기.
                  '세탁기',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row( // 세탁기 아이콘들 띄우기.
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
                SizedBox(height: 30), // 빈 공간 만들기.
                Text( // 건조기 텍스트 띄우기.
                  '건조기',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row( // 건조기 아이콘들 띄우기.
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
          Container( // 하단 네비게이션 바 담을 Container 위젯.
            height: 60, // Container 높이 설정.
            color: Palette.khblue, // Contrainer 색 설정.
            child: Row( // Contrainer 안에 담을 위젯 설정. 여기선 Row 위젯을 넣었음.
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Row 위젯 내에서의 나열 방법 설정.
              children: [ // Row 위젯 안에 들어갈 위젯들 설정.
                IconButton( // 친구 화면용 아이콘.
                  onPressed: (){ // 눌렸을 때의 동작 정의.
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FriendScreen(reservated: widget.reservated))); // FriendScreen로 이동.
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
