import 'package:apptest/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:apptest/screens/home_screen.dart';

class ReservationScreen extends StatefulWidget {
  final int waitings;
  bool reservated;
  ReservationScreen({super.key, required this.waitings, required this.reservated});

  @override
  ReservationScreenState createState() => ReservationScreenState();
}

class ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('예약'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '대기열: ${widget.waitings}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                Text(
                  '예상 대기시간: ${widget.waitings * 50}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(widget.waitings, (index) {
                return const Icon(
                  Icons.account_circle,
                  size: 40
                  );
              }),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 대기열 등록 로직 추가
                  setState(() {
                    widget.reservated = true;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(floor: 3, waitings: 2, reservated: widget.reservated)));
                  });
                },
                child: const Text('대기열 등록'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '주의사항:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // 여기에 주의사항 내용을 추가할 수 있습니다.
          ],
        ),
      ),
    );
  }
}
