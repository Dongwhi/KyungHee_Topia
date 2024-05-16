import 'package:flutter/material.dart';
import 'package:apptest/config/palette.dart';
import 'package:apptest/screens/home_screen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override 
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{
  var isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Container(
        decoration: const BoxDecoration( // BoxDecoration으로 네모난 틀을 사용할 것.
          image: DecorationImage( // DecorationImage로 이미지를 틀에 담을 것.
            image: AssetImage('assets/images/Seal.png'), // 이미지는 image/Seal.png를 사용할 것.
            // fit: BoxFit.fill, // 이미지가 여백을 자동으로 채우도록 함.
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Enter email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Enter password'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Enter phone sumber'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                },
                child: Container(
                  width: 80,
                  height: 60,
                  color: Palette.khred,
                  child: const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 3,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}