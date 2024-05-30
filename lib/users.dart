import 'package:hive/hive.dart';

part 'users.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String name;

  @HiveField(1)
  String nickname;

  @HiveField(2)
  String id;

  @HiveField(3)
  String password;

  @HiveField(4)
  int floor;

  @HiveField(5)
  bool nextlogin;

  @HiveField(6)
  List<int> reservated; // [0 or 1, 세탁기 층, 세탁기번호, 건조기 층, 건조기번호]

  @HiveField(7)
  int warning;

  @HiveField(8)
  List<String> friends;

  @HiveField(9)
  List<String> chatlist;
  
  User(this.name, this.nickname, this.id, this.password, this.floor, this.nextlogin, this.reservated, this.warning, this.friends, this.chatlist);
}