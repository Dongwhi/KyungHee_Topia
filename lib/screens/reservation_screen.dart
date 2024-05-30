import 'package:apptest/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:apptest/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../users.dart';

class ReservationScreen extends StatefulWidget {
  final username;
  final machinenum;
  final floor;
  ReservationScreen({super.key, required this.username, required this.machinenum, required this.floor});

  @override
  ReservationScreenState createState() => ReservationScreenState();
}

class ReservationScreenState extends State<ReservationScreen> {
  var box = Hive.box<User>('user_info1');
  var boxwaiting = Hive.box('waiting_info');
  
  String machine_kind = '세탁기';
  
  User userdetect(String user_name) {
    return box.values.firstWhere((user) => user.name == user_name);
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
              Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(username: widget.username)
                        ),
                      );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user_now = userdetect(widget.username);
    int times = boxwaiting.get(widget.floor)[widget.machinenum-1];
    int waiting_count = times ~/ 50 + ((times % 50)==0? 0 : 1);
    if (widget.machinenum == 2 || widget.machinenum == 3){
      machine_kind = '세탁기';
    } else{
      machine_kind = '건조기';
    }

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text('예약: ${widget.floor} 층 ${widget.machinenum} 번 ${machine_kind}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '대기열: $waiting_count 명',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                Text(
                  '예상 대기시간: $times 분',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(waiting_count, (index) {
                return const Icon(
                  Icons.account_circle,
                  size: 40
                  );
              }),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                        child: const Text(
                          '대기열 등록',
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
                  // 대기열 등록 로직 추가
                    int floor_now = widget.floor;
                    List<int> timelist = boxwaiting.get(floor_now);
                    userdetect(widget.username).reservated[0] = 1;
                    if (widget.machinenum == 2 || widget.machinenum == 3){
                      userdetect(widget.username).reservated[1] = widget.floor;
                      userdetect(widget.username).reservated[2] = widget.machinenum;
                      timelist[widget.machinenum-1] = timelist[widget.machinenum-1] + 50;
                    } else{
                      userdetect(widget.username).reservated[3] = widget.floor;
                      userdetect(widget.username).reservated[4] = widget.machinenum;
                      timelist[widget.machinenum-1] = timelist[widget.machinenum-1] + 50;
                    }
                    boxwaiting.put(widget.floor, timelist);
                  _showDialog('', '결제를 진행하시겠습니까?');
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '주의사항: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // 여기에 주의사항 내용을 추가할 수 있습니다.
          ],
        ),
      ),
    );
  }
}
