// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserBoxAdapter extends TypeAdapter<UserBox> {
  @override
  final int typeId = 0;

  @override
  UserBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserBox(
      userId: fields[0] as String,
      isOnboardingProgressDone: fields[1] == null ? false : fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserBox obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.isOnboardingProgressDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
