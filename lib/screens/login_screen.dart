import 'package:apptest/screens/cerification_screen.dart';
import 'package:flutter/material.dart';
import 'package:apptest/config/palette.dart';
import 'package:apptest/screens/home_screen.dart';
import 'package:apptest/screens/no_login_home_screen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override 
 LoginScreenState createState() => LoginScreenState();
}


class LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _nextLogin = false;

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
                  ),
                  const SizedBox(height: 8),
                  // Password Field
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      //obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(floor: 3, waitings: 2, reservated: false),
                            ),
                          );
                        },
                        child: const Text('로그인'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoLoginHomeScreen(floor: 3, waitings: 2),
                            ),
                          );
                        },
                        child:  const Text('로그인 없이 이용'),
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
                      child: const Text('회원가입'),
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