// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasswordInfoAdapter extends TypeAdapter<PasswordInfo> {
  @override
  final int typeId = 1;

  @override
  PasswordInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PasswordInfo(
      hasPassword: fields[0] as bool,
      passwordHash: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PasswordInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hasPassword)
      ..writeByte(1)
      ..write(obj.passwordHash);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
