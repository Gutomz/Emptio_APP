// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarketAdapter extends TypeAdapter<Market> {
  @override
  final int typeId = 2;

  @override
  Market read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Market(
      name: fields[0] as String,
      image: fields[1] as String?,
      createdAt: fields[2] as String,
      updatedAt: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Market obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
