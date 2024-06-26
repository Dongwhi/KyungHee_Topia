// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as bool,
      (fields[6] as List).cast<int>(),
      fields[7] as int,
      (fields[8] as List).cast<String>(),
      (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.nickname)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.floor)
      ..writeByte(5)
      ..write(obj.nextlogin)
      ..writeByte(6)
      ..write(obj.reservated)
      ..writeByte(7)
      ..write(obj.warning)
      ..writeByte(8)
      ..write(obj.friends)
      ..writeByte(9)
      ..write(obj.chatlist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
