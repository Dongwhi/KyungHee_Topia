import 'package:flutter/material.dart';
import 'package:apptest/config/palette.dart';
import 'package:apptest/screens/signup_screen.dart';

class CerificationScreen extends StatefulWidget {
  @override
  _CerificationScreenState createState() => _CerificationScreenState();
}

class _CerificationScreenState extends State<CerificationScreen> {
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _verificationCodeController = TextEditingController();

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
          '본인인증',
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
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _studentIdController,
              decoration: InputDecoration(
                labelText: 'Student ID',
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Add your code to send verification code here
                    print('Verification code sent to: ${_phoneNumberController.text}');
                  },
                  child: Text('Get Code'),
                ),
              ],
            ),
            TextField(
              controller: _verificationCodeController,
              decoration: InputDecoration(
                labelText: 'Verification Code',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your CerificationScreen logic here
                String name = _nameController.text;
                String studentId = _studentIdController.text;
                String phoneNumber = _phoneNumberController.text;
                String verificationCode = _verificationCodeController.text;

                print('Name: $name');
                print('Student ID: $studentId');
                print('Phone Number: $phoneNumber');
                print('Verification Code: $verificationCode');

                // Navigate to SignupScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen(name: name)),
                );
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _phoneNumberController.dispose();
    _verificationCodeController.dispose();
    super.dispose();
  }
}