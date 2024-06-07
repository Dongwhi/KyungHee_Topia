import 'package:flutter/material.dart';
import 'package:apptest/config/palette.dart';
import 'package:apptest/screens/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

class SignupScreen extends StatefulWidget {
  String name;
  SignupScreen({super.key, required this.name});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var box = Hive.box<User>('user_info1');
  final _nicknameController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // final _floorController = TextEditingController();

  int floor_select = 1;

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
          '회원가입',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: 'Nickname',
              ),
            ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
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
                              floor_select = value!;
                            });
                          },
                          value: floor_select, // DropdownButton가 표시하는 현재 선택된 value를 바뀐 value로 만들어줌.
                        ),
                        ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                          'Signup',
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
                // Add your signup logic here
                String nickname = _nicknameController.text;
                String id = _idController.text;
                String password = _passwordController.text;
                String confirmPassword = _confirmPasswordController.text;

                bool floorErrorCheck = false;
                int floor = 1;

                try {
                  floor = int.parse(floor.toString());
                } on FormatException{
                  floorErrorCheck = true;
                }

                if (nickname == "" || id == "" || password== "" || confirmPassword == "" || floorErrorCheck || !(floor >= 1 && floor <= 3)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('비어 있거나 잘못 입력한 칸이 있습니다!'),
                    ),
                  );
                }
                else if (password == confirmPassword) {
                  print('Nickname: $nickname');
                  print('ID: $id');
                  print('Password: $password');

                  //box.add(User(widget.name, nickname, id, password, floor, false, [0, 0, 0, 0], 0, List.empty(growable : true)));  // put()은 key값이 인덱스로 자동 설정됨.
                  box.put(widget.name, User(widget.name, nickname, id, password, floor, false, [0, 0, 0, 0, 0], 0, List.empty(growable : true), ['$floor_select층 채팅방']));

                  // Navigate to HomeScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else {
                  // Handle password mismatch
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Passwords do not match'),
                    ),
                  );
                }
                // if (password == confirmPassword) {
                //   print('Nickname: $nickname');
                //   print('ID: $id');
                //   print('Password: $password');

                //   //box.add(User(widget.name, nickname, id, password, floor, false, [0, 0, 0, 0], 0, List.empty(growable : true)));  // put()은 key값이 인덱스로 자동 설정됨.
                //   box.put(widget.name, User(widget.name, nickname, id, password, floor, false, [0, 0, 0, 0], 0, List.empty(growable : true), ['$floor층 채팅방']));

                //   // Navigate to HomeScreen
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => LoginScreen()),
                //   );
                // } else {
                //   // Handle password mismatch
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text('Passwords do not match'),
                //     ),
                //   );
                // }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}




