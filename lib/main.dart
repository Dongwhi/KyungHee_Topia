import 'package:flutter/material.dart';
import 'package:apptest/screens/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'users.dart';


void main() async {
  
  await Hive.initFlutter(); // Hive 초기화하기. Hive: 로걸 데이터베이스 툴.

  Hive.registerAdapter(UserAdapter()); // 어댑터 적용. 직접 정의한 Box Type을 읽을 수 있게 해주기.

  var box = await Hive.openBox<User>('user_info1'); // Hive의 데이터 저장 단위인 box 열기. user_info 박스. 없으면 만들고, 있으면 엶.
  // box.clear(); // 박스 초기화
  // box.put('John Doe', User('John Doe', 'Johnny', 'john_doe_001', 'pass1234', 2, false, [0, 0, 0, 0, 0], 0, 
  // ['Jane Smith', 'Michael Brown', 'Emily Davis', 'Robert Wilson', 'Lisa Taylor', 'David Johnson', 'Amy Clark', 'Chris White'], ['2층 채팅방']));
  // box.put('Jane Smith', User('Jane Smith', 'Janie', 'jane_smith_002', 'pass5678', 2, false, [0, 0, 0, 0, 0], 0, [], ['2층 채팅방']));
  // box.put('Michael Brown', User('Michael Brown', 'Mike', 'michael_brown_003', 'password9876', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
  // box.put('Emily Davis', User('Emily Davis', 'Em', 'emily_davis_004', 'pass4321', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
  // box.put('Robert Wilson', User('Robert Wilson', 'Rob', 'robert_wilson_005', 'pass8765', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
  // box.put('Lisa Taylor', User('Lisa Taylor', 'Liza', 'lisa_taylor_006', 'password5432', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
  // box.put('David Johnson', User('David Johnson', 'Dave', 'david_johnson_007', 'pass2345', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
  // box.put('Amy Clark', User('Amy Clark', 'Ames', 'amy_clark_008', 'pass6789', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
  // box.put('Chris White', User('Chris White', 'Chris', 'chris_white_009', 'pass0987', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
  // box.put('Karen Harris', User('Karen Harris', 'Kari', 'karen_harris_010', 'pass7654', 2, false, [0, 0, 0, 0, 0], 0, [], ['2층 채팅방']));

  var boxwaiting = await Hive.openBox('waiting_info'); // 세탁기 건조기 대기시간 박스
  // boxwaiting.clear(); // 대기시간 정보 초기화
  // boxwaiting.put(1, [33, 0, 0, 0, 12]);
  // boxwaiting.put(2, [0, 32, 120, 25, 84]);
  // boxwaiting.put(3, [47, 25, 78, 47, 0]);

  var boxchatting = await Hive.openBox('chatting_info'); // 채팅 박스
  // boxchatting.clear();
  // boxchatting.put('1층 채팅방', [{'Chris White': 'Hello!'}]);
  // boxchatting.put('2층 채팅방', [{'Jane Smith': 'Hello!'}, {'Karen Harris':'let\'s go'}]);
  // boxchatting.put('3층 채팅방', [{'Emily Davis': 'Hello!'}, {'David Johnson':'Hi!'}]);
  // boxchatting.put('317호', [{'Emily Davis': '빨래 언제할까?'}, {'Robert Wilson':'7시에 하자'}]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget { // 가장 바탕에 깔리는 위젯

  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { // build 함수 실행(출력은 widget)
    // final box = Hive.box<User>('user_info1');
    // final boxwaiting = Hive.box('waiting_info');
    // final boxchatting = Hive.box('chatting_info');

    // box.put('John Doe', User('John Doe', 'Johnny', 'john_doe_001', 'pass1234', 2, false, [0, 0, 0, 0, 0], 0, 
    // ['Jane Smith', 'Michael Brown', 'Emily Davis', 'Robert Wilson', 'Lisa Taylor', 'David Johnson', 'Amy Clark', 'Chris White'], ['2층 채팅방']));
    // box.put('Jane Smith', User('Jane Smith', 'Janie', 'jane_smith_002', 'pass5678', 2, false, [0, 0, 0, 0, 0], 0, [], ['2층 채팅방']));
    // box.put('Michael Brown', User('Michael Brown', 'Mike', 'michael_brown_003', 'password9876', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
    // box.put('Emily Davis', User('Emily Davis', 'Em', 'emily_davis_004', 'pass4321', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
    // box.put('Robert Wilson', User('Robert Wilson', 'Rob', 'robert_wilson_005', 'pass8765', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
    // box.put('Lisa Taylor', User('Lisa Taylor', 'Liza', 'lisa_taylor_006', 'password5432', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
    // box.put('David Johnson', User('David Johnson', 'Dave', 'david_johnson_007', 'pass2345', 3, false, [0, 0, 0, 0, 0], 0, [], ['3층 채팅방']));
    // box.put('Amy Clark', User('Amy Clark', 'Ames', 'amy_clark_008', 'pass6789', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
    // box.put('Chris White', User('Chris White', 'Chris', 'chris_white_009', 'pass0987', 1, false, [0, 0, 0, 0, 0], 0, [], ['1층 채팅방']));
    // box.put('Karen Harris', User('Karen Harris', 'Kari', 'karen_harris_010', 'pass7654', 2, false, [0, 0, 0, 0, 0], 0, [], ['2층 채팅방']));
    
    // boxwaiting.clear(); // 대기시간 정보 초기화
    // boxwaiting.put(1, [33, 0, 0, 0, 12]);
    // boxwaiting.put(2, [0, 32, 120, 25, 84]);
    // boxwaiting.put(3, [47, 25, 78, 47, 0]);

    // boxchatting.clear();
    // boxchatting.put('2층 채팅방', [{'Jane Smith': 'Hello!'}, {'Karen Harris':'let\'s go'}]);
    // boxchatting.put('317호', [{'Emily Davis': '빨래 언제할까?'}, {'Robert Wilson':'7시에 하자'}]);

    return const MaterialApp(
      title: 'Kyung-Hee Topia',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: LoginScreen(), //LoginScreen 위젯을 불러옴
    );
  }
}

