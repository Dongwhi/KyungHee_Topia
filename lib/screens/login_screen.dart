import 'package:apptest/screens/cerification_screen.dart';
import 'package:flutter/material.dart';
import 'package:apptest/config/palette.dart';
import 'package:apptest/screens/home_screen.dart';
import 'package:apptest/screens/no_login_home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override 
 LoginScreenState createState() => LoginScreenState();
}


class LoginScreenState extends State<LoginScreen> {

  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstfloorController = TextEditingController();
  final _secondfloorController = TextEditingController();
  final _thirdfloorController = TextEditingController();
  bool _nextLogin = false;
  
  //final box = Hive.box<User>('user_info');
  final box = Hive.box<User>('user_info1');
  final boxwaiting = Hive.box('waiting_info');
  final boxchatting = Hive.box('chatting_info');

  bool isChecked = false;

  bool isValidUser(String idinput, String passwordinput) {
    return box.values.any((user) => user.id == idinput && user.password == passwordinput); // values(): 모든 키값에 대한 value(User 객체) 리스트를 반환. any(): 리스트에 조건을 만족하는 요소가 있는지 검사
  }

  String getusername(String idinput, String passwordinput) {
    return box.values.firstWhere((user) => user.id == idinput && user.password == passwordinput).name; // firstWhere(): 리스트에서 조건을 만족하는 가장 앞선 요소(User 객체) 반환
  }
  
  void _showDialog(String title, String content) { // 팝업 함수
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  // void _login() async { // 로그인 함수
  //   final id = _idController.text;
  //   final password = _passwordController.text;

  //   bool isValid = await _isValidUser(id, password); // 회원가입된 유저인지 검사

  //   if (isValid) { // 회원가입 된 유저라면
  //     String username = await getusername(id, password); // 유저 이름 넘겨줘야 되니까 변수로 만들고
  //     MaterialPageRoute(builder: (context) => HomeScreen(username: username)); // 홈 화면으로 이동
  //   } else { // 회원가입 된 유저가 아니라면
  //     _showDialog('Error', '다시 입력해주세요'); // 다시 입력해주세요 팝업 띄움
  //   }
  // }

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
          '로그인',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 50),
                  Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/images/Seal.png',
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      '경희토피아',
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 200),
                  // ID Field
                  TextField(
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                    //obscureText: true, // 입력한거 안보이게 하는 코드
                  ),
                  const SizedBox(height: 8),
                  // Password Field
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    //obscureText: true, // 입력한거 안보이게 하는 코드
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value){
                          setState(() {
                            isChecked = value!;  
                          });
                        },
                      ),
                      Text('유저 정보, 세탁기 시간, 채팅방 초기화')
                    ],
                  ),


                  // TextField(
                  //   controller: _firstfloorController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'floor 1',
                  //   ),
                  //   //obscureText: true, // 입력한거 안보이게 하는 코드
                  // ),
                  // const SizedBox(height: 16),
                  // TextField(
                  //   controller: _secondfloorController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'floor 2',
                  //   ),
                  //   //obscureText: true, // 입력한거 안보이게 하는 코드
                  // ),
                  // const SizedBox(height: 16),
                  // TextField(
                  //   controller: _thirdfloorController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'floor 3',
                  //   ),
                  //   //obscureText: true, // 입력한거 안보이게 하는 코드
                  // ),
                  // const SizedBox(height: 16),


                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text(
                          '로그인',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(	//모서리를 둥글게
                            borderRadius: BorderRadius.circular(3)
                          ),
                          backgroundColor: Palette.khblue, //배경색
                          //surfaceTintColor: Palette.khblue,
                          //foregroundBuilder: Colors.white,//글자색
                          fixedSize: Size(100, 40),	//width, height
                          
                          //child 정렬
                          // alignment: Alignment.centerLeft,	
                          // textStyle: const TextStyle(
                          //   fontSize: 15,
                          //   color: Colors.white,
                          //   ),
                        ),
                        onPressed: () {
                          // 핸도폰용 유저, 세탁기 시간, 채팅창 수동으로 넣는 기능
                          // List<String> times_string = _firstfloorController.text.split(' ').toList();
                          // List<int> times_int = [0, 0, 0, 0, 0];
                          // for (int i = 0; i < 5; i++){
                          //   times_int[i] = int.parse(times_string[i]);
                          // }
                          // boxwaiting.put(1, times_int);

                          // times_string = _secondfloorController.text.split(' ').toList();
                          // for (int i = 0; i < 5; i++){
                          //   times_int[i] = int.parse(times_string[i]);
                          // }
                          // boxwaiting.put(2, times_int);

                          // times_string = _thirdfloorController.text.split(' ').toList();
                          // for (int i = 0; i < 5; i++){
                          //   times_int[i] = int.parse(times_string[i]);
                          // }
                          // boxwaiting.put(3, times_int);
                          // boxwaiting.put(1, [33, 0, 0, 0, 12]);
                          // boxwaiting.put(2, [0, 32, 120, 25, 84]);
                          // boxwaiting.put(3, [47, 25, 78, 47, 0]);
                          if (isChecked){
                            box.put('John Doe', User('John Doe', 'Johnny', 'john_doe_001', 'pass1234', 2, false, [0, 0, 0, 0, 0], 0, 
                            ['Jane Smith', 'Michael Brown', 'Emily Davis', 'Robert Wilson', 'Lisa Taylor', 'David Johnson', 'Amy Clark', 'Chris White'], ['2층 채팅방']));
                            box.put('Jane Smith', User('Jane Smith', 'Janie', 'jane_smith_002', 'pass5678', 2, false, [0, 0, 0, 0, 0], 0, [], ['2층 채팅방']));
                            box.put('Michael Brown', User('Michael Brown', 'Mike', 'michael_brown_003', 'password9876', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
                            box.put('Emily Davis', User('Emily Davis', 'Em', 'emily_davis_004', 'pass4321', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
                            box.put('Robert Wilson', User('Robert Wilson', 'Rob', 'robert_wilson_005', 'pass8765', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
                            box.put('Lisa Taylor', User('Lisa Taylor', 'Liza', 'lisa_taylor_006', 'password5432', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
                            box.put('David Johnson', User('David Johnson', 'Dave', 'david_johnson_007', 'pass2345', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
                            box.put('Amy Clark', User('Amy Clark', 'Ames', 'amy_clark_008', 'pass6789', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
                            box.put('Chris White', User('Chris White', 'Chris', 'chris_white_009', 'pass0987', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
                            box.put('Karen Harris', User('Karen Harris', 'Kari', 'karen_harris_010', 'pass7654', 2, false, [0, 0, 0, 0, 0], 0, [], ['2층 채팅방']));
                            boxwaiting.put(1, [33, 0, 0, 0, 12]);
                            boxwaiting.put(2, [0, 32, 120, 25, 84]);
                            boxwaiting.put(3, [47, 25, 78, 47, 0]);
                            boxchatting.put('1층 채팅방', [{'Chris White': 'Hello!'}]);
                            boxchatting.put('2층 채팅방', [{'Jane Smith': 'Hello!'}, {'Karen Harris':'let\'s go'}]);
                            boxchatting.put('3층 채팅방', [{'Emily Davis': 'Hello!'}, {'David Johnson':'Hi!'}]);
                            boxchatting.put('317호', [{'Emily Davis': '빨래 언제할까?'}, {'Robert Wilson':'7시에 하자'}]);
                          }


                          // //_login();
                          final id = _idController.text;
                          final password = _passwordController.text;
                          bool isValid = isValidUser(id, password);
                          if (isValid) { // 회원가입 된 유저라면
                            //_showDialog('Welcome!', '환영합니다!');
                            String username = getusername(id, password); // 유저 이름 넘겨줘야 되니까 변수로 만들고
                            Navigator.push(  // 홈 화면으로 이동
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(username: username)
                                )
                              );
                            //  Navigator.push(  // 홈 화면으로 이동
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => NoLoginHomeScreen()
                            //     )
                            //   );
                          } else { // 회원가입 된 유저가 아니라면
                            _showDialog('Error', '다시 입력해주세요'); // 다시 입력해주세요 팝업 띄움
                          }

                            //  Navigator.push(  // 홈 화면으로 이동
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => NoLoginHomeScreen()
                            //     )
                            //   );
                        },
                      ),
                      ElevatedButton(
                        child: const Text(
                          '로그인 없이 이용',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(	//모서리를 둥글게
                            borderRadius: BorderRadius.circular(3)
                          ),
                          backgroundColor: Palette.khblue,
                          fixedSize: Size(150, 40),
                        ),
                        onPressed: () {
                          // 핸도폰용 유저, 세탁기 시간, 채팅창 수동으로 넣는 기능
                          // List<String> times_string = _firstfloorController.text.split(' ').toList();
                          // List<int> times_int = [0, 0, 0, 0, 0];
                          // for (int i = 0; i < 5; i++){
                          //   times_int[i] = int.parse(times_string[i]);
                          // }
                          // boxwaiting.put(1, times_int);

                          // times_string = _secondfloorController.text.split(' ').toList();
                          // for (int i = 0; i < 5; i++){
                          //   times_int[i] = int.parse(times_string[i]);
                          // }
                          // boxwaiting.put(2, times_int);

                          // times_string = _thirdfloorController.text.split(' ').toList();
                          // for (int i = 0; i < 5; i++){
                          //   times_int[i] = int.parse(times_string[i]);
                          // }
                          // boxwaiting.put(3, times_int);
                          // boxwaiting.put(1, [33, 0, 0, 0, 12]);
                          // boxwaiting.put(2, [0, 32, 120, 25, 84]);
                          // boxwaiting.put(3, [47, 25, 78, 47, 0]);
                          if (isChecked){
                            box.put('John Doe', User('John Doe', 'Johnny', 'john_doe_001', 'pass1234', 2, false, [0, 0, 0, 0, 0], 0, 
                            ['Jane Smith', 'Michael Brown', 'Emily Davis', 'Robert Wilson', 'Lisa Taylor', 'David Johnson', 'Amy Clark', 'Chris White'], ['2층 채팅방']));
                            box.put('Jane Smith', User('Jane Smith', 'Janie', 'jane_smith_002', 'pass5678', 2, false, [0, 0, 0, 0, 0], 0, [], ['2층 채팅방']));
                            box.put('Michael Brown', User('Michael Brown', 'Mike', 'michael_brown_003', 'password9876', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
                            box.put('Emily Davis', User('Emily Davis', 'Em', 'emily_davis_004', 'pass4321', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
                            box.put('Robert Wilson', User('Robert Wilson', 'Rob', 'robert_wilson_005', 'pass8765', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
                            box.put('Lisa Taylor', User('Lisa Taylor', 'Liza', 'lisa_taylor_006', 'password5432', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
                            box.put('David Johnson', User('David Johnson', 'Dave', 'david_johnson_007', 'pass2345', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
                            box.put('Amy Clark', User('Amy Clark', 'Ames', 'amy_clark_008', 'pass6789', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
                            box.put('Chris White', User('Chris White', 'Chris', 'chris_white_009', 'pass0987', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
                            box.put('Karen Harris', User('Karen Harris', 'Kari', 'karen_harris_010', 'pass7654', 2, false, [0, 0, 0, 0, 0], 0, [], ['2층 채팅방']));
                            boxwaiting.put(1, [33, 0, 0, 0, 12]);
                            boxwaiting.put(2, [0, 32, 120, 25, 84]);
                            boxwaiting.put(3, [47, 25, 78, 47, 0]);
                            boxchatting.put('1층 채팅방', [{'Chris White': 'Hello!'}]);
                            boxchatting.put('2층 채팅방', [{'Jane Smith': 'Hello!'}, {'Karen Harris':'let\'s go'}]);
                            boxchatting.put('3층 채팅방', [{'Emily Davis': 'Hello!'}, {'David Johnson':'Hi!'}]);
                            boxchatting.put('317호', [{'Emily Davis': '빨래 언제할까?'}, {'Robert Wilson':'7시에 하자'}]);
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoLoginHomeScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Stay Logged In Checkbox
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _nextLogin,
                        onChanged: (bool? value) {
                          setState(() {
                            _nextLogin = value!;
                          });
                        },
                      ),
                      const Text('로그인 유지'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Signup
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CerificationScreen()),
                        );
                      },
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          color: Palette.khblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}