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
  final _floorController = TextEditingController();

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
            TextField(
              controller: _floorController,
              decoration: InputDecoration(
                labelText: 'Floor',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your signup logic here
                String nickname = _nicknameController.text;
                String id = _idController.text;
                String password = _passwordController.text;
                String confirmPassword = _confirmPasswordController.text;
                bool floorErrorCheck = false;
                int floor = 0;
                try {
                  floor = int.parse(_floorController.text);
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
                  box.put(widget.name, User(widget.name, nickname, id, password, floor, false, [0, 0, 0, 0], 0, List.empty(growable : true), ['${floor}층 채팅방']));

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
              },
              child: Text('Signup'),
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




