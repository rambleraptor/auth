// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedAccountAdapter extends TypeAdapter<SavedAccount> {
  @override
  final int typeId = 0;

  @override
  SavedAccount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedAccount(
      id: fields[0] as String,
      secret: fields[1] as String,
      issuer: fields[2] as String,
      username: fields[3] as String,
    )
      ..createdAt = fields[4] as DateTime
      ..tapped = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, SavedAccount obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.secret)
      ..writeByte(2)
      ..write(obj.issuer)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.tapped);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedAccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
