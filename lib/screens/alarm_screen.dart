import 'package:flutter/material.dart';
import '../config/palette.dart';


class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  int _completedNotification = 1;
  int _queueNotification = 1;
  String _laundryNotification = '소리와 진동';
  String _chatNotification = '소리와 진동';

  final List<int> notificationOptions = [0, 1, 2, 3, 4, 5];
  final List<String> alertOptions = ['소리와 진동', '소리만', '진동만'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Palette.khsilver,
        ),
        backgroundColor: Palette.khblue,
        title: const Text(
          '알람설정',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildDropdown(
              '완료 알림',
              _completedNotification,
              (int? newValue) {
                setState(() {
                  _completedNotification = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            buildDropdown(
              '대기열 알림',
              _queueNotification,
              (int? newValue) {
                setState(() {
                  _queueNotification = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            buildRadioGroup(
              '세탁 알림',
              _laundryNotification,
              (String? newValue) {
                setState(() {
                  _laundryNotification = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            buildRadioGroup(
              '채팅 알림',
              _chatNotification,
              (String? newValue) {
                setState(() {
                  _chatNotification = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(String title, int currentValue, ValueChanged<int?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 18)),
        DropdownButton<int>(
          value: currentValue,
          items: notificationOptions.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget buildRadioGroup(String title, String currentValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 18)),
        Column(
          children: alertOptions.map((String value) {
            return RadioListTile<String>(
              title: Text(value),
              value: value,
              groupValue: currentValue,
              onChanged: onChanged,
            );
          }).toList(),
        ),
      ],
    );
  }
}

